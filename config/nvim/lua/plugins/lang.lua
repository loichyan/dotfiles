-- Language specified plugins

return {
  -- Json
  { "b0o/schemastore.nvim", lazy = true },
  -- Rust
  {
    "simrat39/rust-tools.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      tools = {
        inlay_hints = { auto = false },
      },
      server = {
        standalone = false,
      },
    },
  },
  {
    "Saecki/crates.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      popup = { border = "rounded" },
      null_ls = {
        enabled = true,
      },
    },
  },
}
