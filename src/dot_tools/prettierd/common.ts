import { Buffer } from "node:buffer";

export type Bytes = Uint8Array;

export interface Reader {
  read(buf: Bytes): Promise<number | null>;
}

export interface Writer {
  write(data: Bytes): Promise<number>;
}

// deno-lint-ignore no-explicit-any
export interface CliOptions extends Record<string, any> {
  filepath: string;
  config?: string | boolean;
  configPrecedence: "cli-override" | "file-override" | "prefer-file";
  editorconfig: boolean;
}

export enum Request {
  Ping = 0,
  Stop = 1,
  DebugInfo = 2,
  Format = 100,
}

export enum Response {
  Ok = 0,
  Err = 1,
}

export function u32ToBytes(i: number): Bytes {
  const buf = Buffer.alloc(4);
  buf.writeUInt32BE(i);
  return buf;
}

export function bytesToU32(bytes: Bytes): number {
  return Buffer.from(bytes).readUint32BE();
}

/**
 * Performs an operation, discarding any error.
 */
// deno-lint-ignore no-explicit-any
export function tryCall<A extends any[], R>(op: (...args: A) => R, ...args: A): R | undefined {
  try {
    const r = op(...args);
    return r instanceof Promise ? (r.catch((_) => {}) as R) : r;
  } catch (_) {
    // Do nothing
  }
}

/**
 * Performs an I/O operation, discarding "not found" errors.
 */
// deno-lint-ignore no-explicit-any
export async function tryFile<A extends any[], R>(
  op: (...args: A) => Promise<R>,
  ...args: A
): Promise<R | undefined> {
  try {
    return await op(...args);
  } catch (e) {
    if (!(e instanceof Deno.errors.NotFound)) {
      throw e;
    }
  }
}

/**
 * Reads until `buf` is fulfilled.
 */
export async function readExact(reader: Reader, buf: Bytes | number): Promise<Bytes> {
  buf = typeof buf === "number" ? Buffer.alloc(buf) : buf;
  let cur = buf;
  while (cur.length > 0) {
    const d = await reader.read(cur);
    if (d === null) throw new Deno.errors.UnexpectedEof();
    cur = cur.subarray(d);
  }
  return buf;
}

export async function readAll(reader: Reader): Promise<Bytes> {
  const chunks: Buffer[] = [];
  do {
    const buf = Buffer.alloc(4096);
    const d = await reader.read(buf);
    if (d === null) break;
    chunks.push(buf.subarray(0, d));
  } while (true);
  return Buffer.concat(chunks);
}

export async function writeAll(writer: Writer, data: Bytes) {
  let cur = data;
  while (cur.length > 0) {
    const d = await writer.write(cur);
    cur = cur.subarray(d);
  }
}

export async function sleep(ms: number) {
  await new Promise((ok) => setTimeout(() => ok(undefined), ms));
}

let encoder: TextEncoder | undefined = undefined;
export function encode(text: string): Bytes {
  encoder = encoder ?? new TextEncoder();
  return encoder.encode(text);
}

let decoder: TextDecoder | undefined = undefined;
export function decode(bytes: Bytes): string {
  decoder = decoder ?? new TextDecoder("UTF-8");
  return decoder.decode(bytes);
}

export function encodeErr(err: Error): Bytes {
  return encode(
    JSON.stringify({
      message: err.message,
      cause: err.cause,
      stack: err.stack,
    }),
  );
}

export function decodeErr(data: Bytes): Error {
  const obj = JSON.parse(decode(data));
  return Object.assign(new Error(obj.message), {
    cause: obj.cause,
    stack: obj.stack,
  });
}

export type ConnOptions = { transport: "tcp"; hostname: "127.0.0.1"; port: number };

/**
 * Writes the connection file *atomically*.
 */
export async function writeConnFile(path: string, options: ConnOptions) {
  const temp = await Deno.makeTempFile();
  await Deno.writeFile(temp, u32ToBytes(options.port));
  await Deno.rename(temp, path);
}

export async function readConnFile(path: string): Promise<ConnOptions> {
  const f = await Deno.open(path);
  const port = await readExact(f, 4).then(bytesToU32);
  return { transport: "tcp", hostname: "127.0.0.1", port };
}

export async function entrypoint(main: () => Promise<void>): Promise<never> {
  try {
    await main();
    Deno.exit(0);
  } catch (e) {
    console.error(e);
    Deno.exit(1);
  }
}
