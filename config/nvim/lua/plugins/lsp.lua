local Keymap = require("deltavim.core.keymap")

---@type lspconfig.options
local servers = {
  clangd = {},
  cssls = {},
  jsonls = {},
  lua_ls = {},
  pyright = {},
  rnix = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        ---@diagnostic disable-next-line:assign-type-mismatch
        checkOnSave = { command = "clippy" },
      },
    },
  },
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
        stylua = true,
      },
    },
  },
  {
    "mason.nvim",
    opts = {
      ensure_installed = {},
    },
  },
  ----------------
  -- My plugins --
  ----------------
  -- inc-rename
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    keys = function()
      local function rename() return ":IncRename " .. vim.fn.expand("<cword>") end

      -- stylua: ignore
      return Keymap.Collector()
        :map({
          { "@lsp.rename:inc_rename", rename, "Rename with preview", expr = true },
        })
        :collect_lazy()
    end,
    config = true,
  },
}
