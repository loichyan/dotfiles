local Util = require("deltavim.util")

return {
  {
    "nvim-lspconfig",
    opts = { servers = require("custom.lsp") },
  },
  {
    "none-ls.nvim",
    opts = function(_, opts)
      return Util.merge({}, opts, {
        sources_with = {
          formatting = {
            black = true,
            cue_fmt = true,
            fish_indent = true,
            prettierd = true,
            shfmt = true,
            stylua = true,
          },
          diagnostics = {
            cue_fmt = true,
            fish = true,
            hadolint = true,
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
