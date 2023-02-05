-- Set border of some LazyVim plugins to rounded

return {
  -- lazyvim.plugins.coding
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local bordered = require("cmp.config.window").bordered
      return vim.tbl_deep_extend("force", opts, {
        window = {
          completion = bordered(BORDER_STYLE),
          documentation = bordered(BORDER_STYLE),
        },
      })
    end,
  },
  -- lazyvim.plugins.editor
  {
    "folke/which-key.nvim",
    opts = { window = { border = BORDER_STYLE } },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = { preview_config = { border = BORDER_STYLE } },
  },
  -- lazyvim.plugins.lsp
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Set LspInfo border
      require("lspconfig.ui.windows").default_options.border = BORDER_STYLE
      return opts
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = { border = BORDER_STYLE },
    },
  },
  -- lazyvim.plugins.ui
  {
    "folke/noice.nvim",
    opts = {
      presets = { lsp_doc_border = true },
    },
  },
}
