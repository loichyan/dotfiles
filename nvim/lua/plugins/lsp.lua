local Util = require("deltavim.util")

---@type lspconfig.options|table<string,boolean>
---@diagnostic disable:missing-fields
local servers = {
  bashls = true,
  clangd = true,
  cssls = true,
  denols = true,
  eslint = true,
  gopls = true,
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
  nil_ls = true,
  pyright = true,
  taplo = true,
  tailwindcss = true,
  texlab = true,
  tsserver = true,
  typos_lsp = true,
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
servers = Util.copy_as_table(servers) --[[@as lspconfig.options]]
for _, server in pairs(Util.copy_as_table(servers)) do
  server.mason = server.mason == true or false
end

return {
  {
    "nvim-lspconfig",
    opts = { servers = servers },
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
            nixfmt = true,
            prettierd = true,
            shfmt = true,
            stylua = true,
          },
          diagnostics = {
            cue_fmt = true,
            fish = true,
            hadolint = true,
          },
        },
      })
    end,
  },
  { "mason.nvim", enabled = false },
  { "mason-lspconfig.nvim", enabled = false },
}
