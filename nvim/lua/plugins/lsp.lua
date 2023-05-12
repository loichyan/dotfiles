local Keymap = require("deltavim.core.keymap")
local Util = require("deltavim.util")

return {
  {
    "nvim-lspconfig",
    opts = { servers = require("custom.lsp") },
  },
  {
    "null-ls.nvim",
    opts = function(_, opts)
      return Util.merge({}, opts, {
        sources_with = {
          formatting = {
            black = true,
            prettier = true,
            shfmt = true,
            stylua = true,
          },
          diagnostics = {
            cspell = {
              filetypes = { "markdown" },
              diagnostics_postprocess = function(diag)
                diag.severity = vim.diagnostic.severity.WARN
              end,
            },
            eslint = true,
            hadolint = true,
            shellcheck = true,
            vale = {
              diagnostics_postprocess = function(diag)
                diag.severity = vim.diagnostic.severity.HINT
              end,
            },
          },
          code_actions = {
            cspell = true,
          },
        },
      })
    end,
  },
  { "mason.nvim", enabled = false },
  { "mason-lspconfig.nvim", enabled = false },
  --
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = function()
      -- stylua: ignore
      return Keymap.Collector()
        :map({
          { "@lsp.symbols_outline", "<Cmd>SymbolsOutline<CR>", "Symbols Outline" },
        })
        :collect_lazy()
    end,
    config = true,
  },
}
