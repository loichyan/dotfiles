local Keymap = require("deltavim.core.keymap")
local Util = require("deltavim.util")

---@type lspconfig.options
local servers = {
  clangd = {},
  cssls = {},
  jsonls = {
    on_attach = function(client)
      client.notify("workspace/didChangeConfiguration", {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })
    end,
  },
  lua_ls = {},
  pyright = {},
  rnix = {},
  taplo = {},
  tsserver = {},
}

-- Use nixpkgs instead of mason.nvim to manage tools
for _, server in pairs(servers) do
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
      formatters = {
        prettier = true,
        shfmt = true,
        stylua = true,
      },
      linters = {
        eslint = true,
        hadolint = true,
        shellcheck = true,
      },
    },
  },
  { "mason.nvim", enabled = false },
  { "mason-lspconfig.nvim", enabled = false },
  ----------------
  -- My plugins --
  ----------------
  -- inc-rename
  {
    "smjonas/inc-rename.nvim",
    cond = NOT_VSCODE,
    cmd = "IncRename",
    init = function()
      local keymaps
      Util.on_lsp_attach(function(client, buffer)
        keymaps = keymaps
          or Keymap.Collector()
            :map({
              {
                "@lsp.rename:inc_rename",
                {
                  function()
                    require("inc_rename")
                    return ":IncRename " .. vim.fn.expand("<cword>")
                  end,
                  "rename",
                },
                "Rename with preview",
                expr = true,
              },
            })
            :collect()
        require("deltavim.core.lsp").set_keymaps(client, buffer, keymaps)
      end)
    end,
    config = true,
  },
}
