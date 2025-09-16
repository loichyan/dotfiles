const baseOptions: Partial<Deno.bundle.Options> = {
  outputDir: "dist",
  platform: "deno",
  format: "esm",
  minify: true,
};

await Deno.bundle({
  ...baseOptions,
  entrypoints: ["prettier-markdown-extended.js", "prettierd/server.ts", "prettier.config.js"],
});

const res = await Deno.bundle({
  ...baseOptions,
  entrypoints: ["prettierd.ts"],
  write: false,
});
for (const f of res.outputFiles!) {
  // Fix bundled imports
  const t = f.text().replaceAll("./prettierd/server.ts", "./prettierd/server.js");
  await Deno.writeTextFile(f.path, t);
}
