/** @type {import("prettier").Config} */
export default {
  plugins: [
    import.meta.resolve("./prettier-markdown-extended.js"),
    import.meta.resolve("prettier-plugin-organize-imports"),
  ],
  printWidth: 100,
  quoteProps: "consistent",
  overrides: [
    {
      files: "*.md", // Files may be provided as an absolute path
      options: {
        printWidth: 80,
        proseWrap: "always",
        emphasisKind: "asterisk",
        strongKind: "asterisk",
      },
    },
  ],
};
