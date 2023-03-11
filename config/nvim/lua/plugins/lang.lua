-- Language specified plugins

return {
  -- Json
  { "b0o/schemastore.nvim", lazy = true },
  -- Rust
  {
    "Saecki/crates.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      popup = { border = "rounded" },
      null_ls = {
        enabled = true,
      },
    },
  },
}
