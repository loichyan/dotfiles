import type * as Prettier from "prettier";
import {
  Bytes,
  bytesToU32,
  CliOptions,
  decode,
  die,
  encode,
  encodeErr,
  readAll,
  readExact,
  Request,
  Response,
  SERVER_HOST,
  tryCall,
  tryFile,
  u32ToBytes,
  writeAll,
} from "./common.ts";

const [portFile, prettierMod] = Deno.args;
const prettier: typeof Prettier = await import(prettierMod);

async function respond(conn: Deno.TcpConn, data: Bytes | string) {
  data = typeof data === "string" ? encode(data) : data;
  await writeAll(conn, u32ToBytes(Response.Ok));
  await writeAll(conn, data);
  conn.closeWrite();
}

// deno-lint-ignore no-explicit-any
async function respondErr(conn: Deno.TcpConn, err: any) {
  err = err instanceof Error ? err : new Error(String(err));
  await writeAll(conn, u32ToBytes(Response.Err));
  await writeAll(conn, encodeErr(err));
  conn.closeWrite();
}

// deno-lint-ignore no-explicit-any
async function recvJson(conn: Deno.TcpConn): Promise<any> {
  const len = await readExact(conn, 4).then(bytesToU32);
  const data = await readExact(conn, len);
  return JSON.parse(decode(data));
}

async function resolveConfig(args: CliOptions): Promise<Prettier.Options | null> {
  const { config, editorconfig, configPrecedence, ...cliConfig } = args;

  // No config file should be loaded.
  if (config === false) return cliConfig;
  const resolved = await tryCall(prettier.resolveConfig, args.filepath, {
    config: typeof config === "string" ? config : undefined,
    editorconfig,
  });

  // CLI options are always taken as fallback.
  if (!resolved) return cliConfig;

  // When set to `prefer-file`, no CLI options are taken into account.
  if (configPrecedence === "prefer-file") return resolved;

  // Respect the specified loading order.
  return configPrecedence === "file-override"
    ? Object.assign(cliConfig, resolved)
    : Object.assign(resolved, cliConfig);
}

async function serve(conn: Deno.TcpConn) {
  const req = (await readExact(conn, 4).then(bytesToU32)) as Request;
  switch (req) {
    case Request.Ping: {
      conn.close();
      return;
    }

    case Request.Stop: {
      await tryFile(Deno.remove, portFile);
      conn.close();
      return Deno.exit(0);
    }

    case Request.DebugInfo: {
      const args: CliOptions = await recvJson(conn);

      const debugInfo = {
        cwd: Deno.cwd(),
        main: import.meta.filename,
        address: conn.localAddr,
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
  const server = Deno.listen({ hostname: SERVER_HOST, port: 0 });
  const serverPort = server.addr.port;

  // Report the port being listened on.
  await Deno.writeFile(portFile, u32ToBytes(serverPort));

  // Process client requests.
  do {
    const conn = await server.accept();
    serve(conn).catch(console.error);
  } while (true);
}

try {
  await main();
} catch (e) {
  die(e);
}
