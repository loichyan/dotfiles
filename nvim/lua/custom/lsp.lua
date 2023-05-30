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
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        check = { command = "clippy" },
        procMacro = { enable = true, attributes = { enable = true } },
      },
    },
  },
  taplo = true,
  texlab = true,
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
servers = Util.copy_as_table(servers) --[[@as lspconfig.options]]
for _, server in pairs(Util.copy_as_table(servers)) do
  server.mason = server.mason == true or false
end

return servers