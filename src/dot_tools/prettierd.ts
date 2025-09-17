#!/usr/bin/env -S deno run -A

/**
 * This file is a port of @fsouza/prettierd for Deno.
 *
 * Original Author: fsouza (https://github.com/fsouza)
 * Original License: ISC
 */

import { Buffer } from "node:buffer";
import { homedir } from "node:os";
import { join } from "node:path";
import {
  bytesToU32,
  CliOptions,
  decode,
  decodeErr,
  die,
  encode,
  readAll,
  readExact,
  Request,
  Response,
  SERVER_HOST,
  sleep,
  tryCall,
  tryFile,
  u32ToBytes,
  writeAll,
} from "./prettierd/common.ts";

const dataDir = join(homedir(), ".prettierd");

async function connect(portFile: string, startNew?: true): Promise<Deno.TcpConn>;
async function connect(portFile: string, startNew: false): Promise<Deno.TcpConn | undefined>;
async function connect(portFile: string, startNew?: boolean): Promise<Deno.TcpConn | undefined> {
  let serverPort: number | undefined;
  let conn: Deno.TcpConn | undefined;
  // Check if server already started
  try {
    const f = await Deno.open(portFile);
    serverPort = bytesToU32(await readExact(f, 4));
    conn = await Deno.connect({ hostname: SERVER_HOST, port: serverPort });
  } catch (e) {
    // Ignore errors if server not started or aborted for any reason.
    if (
      e instanceof Deno.errors.NotFound ||
      e instanceof Deno.errors.UnexpectedEof ||
      e instanceof Deno.errors.ConnectionRefused
    ) {
      await tryFile(Deno.remove, portFile);
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

    await Deno.mkdir(dataDir, { recursive: true });

    const child = fork(serverMod, [portFile, prettierMod], { stdio: "inherit", detached: true });
    child.unref();
    child.on("exit", () => {
      // Server should keep running until explicitly stopped.
      throw new Error("server crashes");
    });

    // Receive the port being listened.
    const buf = Buffer.alloc(4);
    let cur = buf;
    let f: Deno.FsFile | undefined;
    do {
      await sleep(50);
      f = f ?? (await tryFile(Deno.open, portFile));
      const d = (await f?.read(cur)) ?? 0;
      if (d > 0) cur = cur.subarray(d);
    } while (cur.length > 0);

    serverPort = bytesToU32(buf);
    conn = await Deno.connect({ hostname: SERVER_HOST, port: serverPort });
  }

  return conn;
}

// Throws an exception if server returns an error.
async function checkResponse(conn: Deno.TcpConn) {
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
async function sendJson(conn: Deno.TcpConn, val: any) {
  const data = encode(JSON.stringify(val));
  await writeAll(conn, u32ToBytes(data.length));
  await writeAll(conn, data);
}

function parseCliOptions(args: string[]): CliOptions {
  const config: Partial<CliOptions> = {
    configPrecedence: "cli-override",
    editorconfig: true,
  };

  for (const arg of args) {
    const mat = arg.match(/^\-\-([^=]+)(?:=?(.*))$/);
    if (mat === null) {
      config.filepath = arg;
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

  return config as CliOptions;
}

async function main() {
  const serverId = encodeURIComponent(Deno.cwd());
  const portFile = join(dataDir, serverId);

  switch (Deno.args[0]) {
    case "--start": {
      const conn = await connect(portFile);
      await writeAll(conn, u32ToBytes(Request.Ping));
      return;
    }

    case "--restart": {
      let conn = await connect(portFile, false);
      if (conn) {
        await writeAll(conn, u32ToBytes(Request.Stop));
        await tryFile(Deno.remove, portFile);
      }
      conn = await connect(portFile);
      await writeAll(conn, u32ToBytes(Request.Ping));
      return;
    }

    case "--stop": {
      if (!(await tryFile(Deno.stat, dataDir))) return;

      // Stop all started servers
      for await (const ent of Deno.readDir(dataDir)) {
        const portFile = join(dataDir, ent.name);
        const conn = await connect(portFile, false);
        if (!conn) continue;
        await writeAll(conn, u32ToBytes(Request.Stop));
      }

      return;
    }

    case "--debug-info": {
      const conn = await connect(portFile, false);
      const args = parseCliOptions(Deno.args.slice(1));

      // Fetch server debug informations
      let server = null;
      if (conn) {
        await writeAll(conn, u32ToBytes(Request.DebugInfo));
        await sendJson(conn, args);
        await checkResponse(conn);
        server = await readAll(conn).then(decode).then(JSON.parse);
      }

      const debugInfo = {
        cwd: Deno.cwd(),
        main: import.meta.filename,
        args: args ?? Deno.args,
        dataDir: dataDir,
      };
      console.log({ client: debugInfo, server });

      return;
    }

    default: {
      if (Deno.stdin.isTerminal()) throw new Error("file content must be provided from stdin");
      const args = parseCliOptions(Deno.args);

      const conn = await connect(portFile);
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

try {
  await main();
} catch (e) {
  die(e);
}
