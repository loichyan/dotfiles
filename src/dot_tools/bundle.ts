import { denoPlugin } from "@deno/esbuild-plugin";
import { build } from "esbuild";

await build({
  plugins: [denoPlugin()],
  define: {
    "import.meta.DENO_BUNDLE": "true",
  },
  entryPoints: [
    "prettierd.ts",
    "prettierd/server.ts",
    "prettier.config.js",
    "prettier-markdown-extended.js",
  ],
  logLevel: "info",
  bundle: true,
  outdir: "dist",
  platform: "node",
  format: "esm",
  sourcemap: "inline",
  minify: true,
});
