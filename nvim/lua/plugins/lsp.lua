local Keymap = require("deltavim.core.keymap")
local Util = require("deltavim.util")

---@type lspconfig.options|table<string,boolean>
local servers = {
  clangd = true,
  cssls = true,
  hls = true,
  jsonls = {
    settings = { json = { validate = { enable = true } } },
    on_attach = function(client)
      client.notify("workspace/didChangeConfiguration", {
        settings = {
          json = { schemas = require("schemastore").json.schemas() },
        },
      })
    end,
  },
  lua_ls = {
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
          library = { "${3rd}/luv/library" },
        },
      },
    },
  },
  pyright = true,
  rnix = true,
  taplo = true,
  tsserver = true,
  yamlls = {
    settings = { yaml = { validate = true, keyOrdering = false } },
    on_attach = function(client)
      client.notify("workspace/didChangeConfiguration", {
        settings = {
          yaml = { schemas = require("schemastore").yaml.schemas() },
        },
      })
    end,
  },
}

-- Use nixpkgs instead of mason.nvim to manage tools
servers = Util.copy_as_table(servers)
for _, server in pairs(Util.copy_as_table(servers)) do
  server.mason = server.mason == true or false
end

return {
  {
    "nvim-lspconfig",
    opts = { servers = servers },
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
