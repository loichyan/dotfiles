#!/usr/bin/env -S deno run -A

/**
 * This file is a port of @fsouza/prettierd for Deno.
 *
 * Original Author: fsouza (https://github.com/fsouza)
 * Original License: ISC
 */

import { once } from "node:events";
import { homedir } from "node:os";
import { join } from "node:path";
import { promisify } from "node:util";
import {
  bytesToU32,
  CliOptions,
  ConnOptions,
  decode,
  decodeErr,
  encode,
  entrypoint,
  readAll,
  readConnFile,
  readExact,
  Request,
  Response,
  tryCall,
  tryFile,
  u32ToBytes,
  writeAll,
  writeConnFile,
} from "./prettierd/common.ts";

const dataDir = join(homedir(), ".prettierd");
const serverId = encodeURIComponent(Deno.cwd());

async function connect(connFile: string, startNew?: true): Promise<Deno.Conn>;
async function connect(connFile: string, startNew: false): Promise<Deno.Conn | undefined>;
async function connect(connFile: string, startNew?: boolean): Promise<Deno.Conn | undefined> {
  let connOptions: ConnOptions | undefined;
  let conn: Deno.Conn | undefined;
  // Check if server already started
  try {
    connOptions = await readConnFile(connFile);
    conn = await Deno.connect(connOptions);
  } catch (e) {
    // Ignore errors if server does not start or was aborted for any reason.
    if (e instanceof Deno.errors.NotFound || e instanceof Deno.errors.ConnectionRefused) {
      await tryFile(Deno.remove, connFile);
    } else {
      throw e;
    }
  }

  // Start a new server
  if (conn === undefined) {
    if (startNew === false) return;

    const { fork } = await import("node:child_process");
    const serverMod = import.meta.resolve("./prettierd/server.ts");
    const prettierMod = import.meta.resolve("prettier");

    // Server should keep running until explicitly stopped.
    const server = fork(serverMod, undefined, { stdio: "inherit", detached: true });
    const onExit = (e: unknown) => {
      server.removeAllListeners();
      throw e instanceof Error ? e : new Error("server crashes");
    };
    server.on("error", onExit);
    server.on("exit", onExit);

    // Wait for server to really start.
    await promisify<object, void>(server.send)({ serverId, prettierMod });
    const [connOptions] = await once(server, "message");
    conn = await Deno.connect(connOptions);

    // Save the connection file.
    await Deno.mkdir(dataDir, { recursive: true });
    await writeConnFile(connFile, connOptions);

    // Do detach the server.
    server.unref();
  }

  return conn;
}

// Throws an exception if server returns an error.
async function checkResponse(conn: Deno.Conn) {
  const resp = (await readExact(conn, 4).then(bytesToU32)) as Response;
  switch (resp) {
    case Response.Ok: {
      return;
    }
    case Response.Err: {
      throw decodeErr(await readAll(conn));
    }
    default: {
      throw new Error("unknown response");
    }
  }
}

// deno-lint-ignore no-explicit-any
async function sendJson(conn: Deno.Conn, val: any) {
  const data = encode(JSON.stringify(val));
  await writeAll(conn, u32ToBytes(data.length));
  await writeAll(conn, data);
}

function parseCliOptions(args: string[]): CliOptions {
  const config: Partial<CliOptions> = {};

  for (const arg of args) {
    const mat = arg.match(/^\-\-([^=]+)(?:=?(.*))$/);
    if (!mat) {
      config.stdinFilepath = arg;
      break;
    }

    let [_, k, v] = mat;
    let any;

    // Handle `--no-flag-name`
    if (k.startsWith("no-")) {
      k = k.slice(3);
      any = false;
    } else if (v === "") {
      any = true;
    } else {
      // Handle numbers and booleans
      any = tryCall(JSON.parse, v);
    }

    // Convert option keys to camelCase
    k = k.replaceAll(/\-(.)/g, ([_, c]) => c.toUpperCase());
    config[k] = any === undefined ? v : any;
  }

  if (!config.stdinFilepath) throw new Error("filepath must be specified");
  else return config as CliOptions;
}

async function start(connFile: string) {
  const conn = await connect(connFile);
  await writeAll(conn, u32ToBytes(Request.Ping));
}

async function stop(connFile: string) {
  const conn = await connect(connFile, false);
  if (conn) await writeAll(conn, u32ToBytes(Request.Stop));
  await tryFile(Deno.remove, connFile);
}

async function main() {
  const connFile = join(dataDir, serverId);

  switch (Deno.args[0]) {
    case "--start": {
      await start(connFile);
      return;
    }

    case "--restart": {
      await stop(connFile);
      await start(connFile);
      return;
    }

    case "--stop": {
      // Stop all started servers
      if (!(await tryFile(Deno.stat, dataDir))) return;
      for await (const ent of Deno.readDir(dataDir)) {
        await stop(join(dataDir, ent.name));
      }
      return;
    }

    case "--debug-info": {
      const args = tryCall(parseCliOptions, Deno.args.slice(1));

      // Fetch server debug informations
      let server;
      const conn = await connect(connFile, false);
      if (conn) {
        await writeAll(conn, u32ToBytes(Request.DebugInfo));
        await sendJson(conn, args ?? {});
        await checkResponse(conn);
        server = await readAll(conn).then(decode).then(JSON.parse);
      }

      // Build client informations
      const debugInfo = {
        cwd: Deno.cwd(),
        main: import.meta.filename,
        dataDir: dataDir,
        cliOptions: args ?? "<error>",
      };

      console.log({
        client: debugInfo,
        server: server ?? "<inactive>",
      });
      return;
    }

    default: {
      if (Deno.stdin.isTerminal()) throw new Error("file content must be provided from stdin");
      const args = parseCliOptions(Deno.args);

      const conn = await connect(connFile);
      await writeAll(conn, u32ToBytes(Request.Format));

      // Report the command line arguments
      await sendJson(conn, args);

      // stdin -> server
      await Deno.stdin.readable.pipeTo(conn.writable, { preventClose: true });
      conn.closeWrite();

      // server -> stdout
      await checkResponse(conn);
      await conn.readable.pipeTo(Deno.stdout.writable, { preventClose: true });
      return;
    }
  }
}

await entrypoint(main);
