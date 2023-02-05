local function disable_formatting(client)
  client.server_capabilities.documentFormattingProvider = false
end

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
    on_attach = function(client)
      disable_formatting(client)
    end,
  },
  cssls = {
    on_attach = function(client)
      disable_formatting(client)
    end,
  },
  rnix = {},
}

-- Use nixpkgs instead of mason.nvim to manage tools
for _, server in pairs(servers) do
  server.mason = server.mason == true or false
end

return {
  -- Add lsp servers
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keymaps = require("lazyvim.plugins.lsp.keymaps")
      local keys = keymaps.get()
      ---@diagnostic disable-next-line:missing-parameter
      vim.list_extend(keys, {
        { "<leader>cr", false },
        {
          "<leader>cc",
          function()
            keymaps.rename()
          end,
          desc = "Rename",
          has = "rename",
        },
      })
    end,
    opts = { servers = servers },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls").builtins
      opts.sources = {
        nls.formatting.prettierd,
        nls.formatting.stylua,
      }
      return opts
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {},
    },
  },
}
