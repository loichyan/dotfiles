local Util = require("deltavim.util")

---@type lspconfig.options|table<string,boolean>
local servers = {
  clangd = true,
  cssls = true,
  jsonls = {
    settings = {
      json = {
        validate = { enable = true },
      },
    },
    on_attach = function(client)
      client.notify("workspace/didChangeConfiguration", {
        settings = {
          json = { schemas = require("schemastore").json.schemas() },
        },
      })
    end,
  },
  yamlls = {
    settings = {
      yaml = {
        validate = true,
        keyOrdering = false,
      },
    },
    on_attach = function(client)
      client.notify("workspace/didChangeConfiguration", {
        settings = {
          yaml = { schemas = require("schemastore").yaml.schemas() },
        },
      })
    end,
  },
  lua_ls = {
    settings = {
      Lua = {
        workspace = {
          library = {
            "${3rd}/luv/library",
          },
        },
      },
    },
  },
  pyright = true,
  rnix = true,
  taplo = true,
  tsserver = true,
}

-- Use nixpkgs instead of mason.nvim to manage tools
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
    opts = {
      sources_with = {
        formatting = {
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
    },
  },
  { "mason.nvim", enabled = false },
  { "mason-lspconfig.nvim", enabled = false },
}
