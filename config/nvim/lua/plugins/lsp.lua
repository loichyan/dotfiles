-- local function disable_formatting(client)
--   client.server_capabilities.documentFormattingProvider = false
-- end

local servers = {
  jsonls = {},
  sumneko_lua = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        ---@diagnostic disable-next-line:assign-type-mismatch
        checkOnSave = { command = "clippy" },
      },
    },
  },
  taplo = {},
  clangd = {},
  tsserver = {
    on_attach = function(_)
      -- disable_formatting(client)
    end,
  },
  cssls = {
    on_attach = function(_)
      -- disable_formatting(client)
    end,
  },
  rnix = {},
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
    opts = function(_, opts)
      local nls = require("null-ls").builtins
      return vim.tbl_deep_extend("force", opts, {
        sources = {
          nls.formatting.prettierd,
          nls.formatting.stylua,
        },
      })
    end,
  },
  {
    "mason.nvim",
    opts = {
      ensure_installed = {},
    },
  },
}
