import { basename } from "node:path";
import type * as Prettier from "prettier";
import {
  Bytes,
  bytesToU32,
  CliOptions,
  ConnOptions,
  decode,
  encode,
  encodeErr,
  entrypoint,
  readAll,
  readExact,
  Request,
  Response,
  tryCall,
  tryFile,
  u32ToBytes,
  writeAll,
  writeConnFile,
} from "./common.ts";

const [connFile, prettierMod] = Deno.args;
const serverId = basename(connFile);

let prettier: typeof Prettier;
let connOptions: ConnOptions;

async function respond(conn: Deno.Conn, data: Bytes | string) {
  data = typeof data === "string" ? encode(data) : data;
  await writeAll(conn, u32ToBytes(Response.Ok));
  await writeAll(conn, data);
  conn.closeWrite();
}

// deno-lint-ignore no-explicit-any
async function respondErr(conn: Deno.Conn, err: any) {
  err = err instanceof Error ? err : new Error(String(err));
  await writeAll(conn, u32ToBytes(Response.Err));
  await writeAll(conn, encodeErr(err));
  conn.closeWrite();
}

// deno-lint-ignore no-explicit-any
async function recvJson(conn: Deno.Conn): Promise<any> {
  const len = await readExact(conn, 4).then(bytesToU32);
  const data = await readExact(conn, len);
  return JSON.parse(decode(data));
}

async function resolveConfig(args: CliOptions): Promise<Prettier.Options> {
  const { stdinFilepath: filepath, config, editorconfig, configPrecedence, ...cli } = args;

  let final: Prettier.Options;
  if (config === false) {
    // If no config file should be resolved, use CLI options.
    final = cli;
  } else {
    const resolved = await tryCall(prettier.resolveConfig, filepath, {
      config: typeof config === "string" ? config : undefined,
      // Editorconfig resolution is enabled by default.
      editorconfig: editorconfig !== false,
    });

    // CLI options are always taken as fallback.
    if (!resolved) final = cli;
    // When set to `prefer-file`, no CLI options are taken into account.
    else if (configPrecedence === "prefer-file") final = resolved;
    // Otherwise `cli-override` is the default precedence.
    else if (configPrecedence === "file-override") final = Object.assign(cli, resolved);
    else final = Object.assign(resolved, cli);
  }

  // Tell perttier the filepath so that it can select a proper parser.
  return Object.assign(final, { filepath });
}

async function serve(conn: Deno.Conn) {
  const req = (await readExact(conn, 4).then(bytesToU32)) as Request;
  switch (req) {
    case Request.Ping: {
      conn.close();
      return;
    }

    case Request.Stop: {
      await tryFile(Deno.remove, connFile);
      conn.close();
      return Deno.exit(0);
    }

    case Request.DebugInfo: {
      const args: CliOptions = await recvJson(conn);

      const debugInfo = {
        cwd: Deno.cwd(),
        main: import.meta.filename,
        id: serverId,
        address: connOptions,
        prettier: prettierMod,
        resolvedConfig: await resolveConfig(args),
      };

      await respond(conn, JSON.stringify(debugInfo));
      return;
    }

    case Request.Format: {
      const args: CliOptions = await recvJson(conn);
      const text = await readAll(conn).then(decode);

      // Format and report encountered errors
      let formatted: string;
      try {
        const config = await resolveConfig(args);
        formatted = await prettier.format(text, config ?? undefined);
      } catch (e) {
        await respondErr(conn, e);
        return;
      }

      await respond(conn, formatted);
      return;
    }

    default: {
      await respondErr(conn, "unknown request");
    }
  }
}

async function main() {
  prettier = await import(prettierMod);
  connOptions = { transport: "tcp", hostname: "127.0.0.1", port: 0 };

  const server = Deno.listen(connOptions);

  // Update the TCP port since it is randomly chosen.
  connOptions.port = server.addr.port;
  await writeConnFile(connFile, connOptions);

  // Process client requests.
  do {
    const conn = await server.accept();
    serve(conn).catch(console.error);
  } while (true);
}

await entrypoint(main);
