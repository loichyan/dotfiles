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
            cue_fmt = true,
            fish_indent = true,
            latexindent = true,
            prettierd = true,
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
            cue_fmt = true,
            eslint = true,
            fish = true,
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
}
