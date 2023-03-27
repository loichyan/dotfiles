-- Language specified plugins

return {
  -- Json
  {
    "b0o/schemastore.nvim",
    cond = NOT_VSCODE,
    lazy = true,
  },
  -- Rust
  {
    "simrat39/rust-tools.nvim",
    cond = NOT_VSCODE,
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
    cond = NOT_VSCODE,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      popup = { border = "rounded" },
      null_ls = {
        enabled = true,
      },
    },
  },
  -- Markdown
  {
    "toppair/peek.nvim",
    cond = NOT_VSCODE,
    ft = { "markdown" },
    build = "deno task build:fast",
    opts = { app = "microsoft-edge" },
    config = function(_, opts)
      local function peek(name)
        return function() require("peek")[name]() end
      end
      vim.api.nvim_create_user_command("PeekOpen", peek("open"), {})
      vim.api.nvim_create_user_command("PeekClose", peek("close"), {})
      require("peek").setup(opts)
    end,
  },
}
