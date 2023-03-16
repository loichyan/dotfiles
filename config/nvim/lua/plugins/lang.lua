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
        settings = {
          ["rust-analyzer"] = {
            ---@diagnostic disable-next-line:assign-type-mismatch
            checkOnSave = { command = "clippy" },
            procMacro = { enable = true, attributes = { enable = true } },
          },
        },
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
