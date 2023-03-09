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
}
