local M = {}

local function disable_formatting(client)
  client.resolved_capabilities.document_formatting = false
end

---@return table
local function sumneko_lua()
  local opt = {
    on_attach = function(client, _)
      disable_formatting(client)
    end,
  }
  -- Lua types for vim.
  local lua_dev = require("lua-dev")
  lua_dev = lua_dev.setup({
    lspconfig = opt,
  })
  -- Load local lua libaray.
  vim.list_extend(
    lua_dev.settings["Lua"].workspace.library,
    { vim.fn.expand("~/.config/nvim/lua") }
  )
  return lua_dev
end

---@param minv MiNV
function M.setup(minv)
  local lsp = minv.plugins.lsp
  local config = minv.plugins.lsp.config

  -- Servers to be installed.
  lsp.installer.ensure_installed = {}

  -- Lsp servers.
  config.servers = {
    -- Lua
    sumneko_lua = sumneko_lua(),
    -- Rust
    rust_analyzer = {
      settings = {
        ["rust-analyzer"] = {
          experimental = {
            procAttrMacros = true,
          },
        },
      },
    },
    -- Toml
    taplo = {},
    -- C/C++
    clangd = {},
    -- Ts/Js
    tsserver = {
      on_attach = function(client, _)
        disable_formatting(client)
      end,
    },
    -- Css
    cssls = {
      on_attach = function(client, _)
        disable_formatting(client)
      end,
    },
    -- Nix
    rnix = {},
  }

  -- Formatters
  config.formatters = {
    -- Lua
    stylua = {},
    -- Prettierd
    prettierd = {},
  }
end

return M
