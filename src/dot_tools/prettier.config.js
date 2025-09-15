/** @type {import("prettier").Config} */
export default {
  plugins: [
    import.meta.resolve("./prettier-markdown-extended.js"),
    import.meta.resolve("prettier-plugin-organize-imports"),
  ],
  printWidth: 100,
  overrides: [
    {
      files: ["*.md"],
      options: { printWidth: 80 },
    },
  ],
};
