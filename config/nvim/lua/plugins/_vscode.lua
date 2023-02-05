-- Disable some LazyVim plugins when running as the backend of VSCode.

local plugins = {
  -- lazyvim.plugins.coding
  { "L3MON4D3/LuaSnip" },
  { "hrsh7th/nvim-cmp" },
  -- lazyvim.plugins.colorshceme
  { "folke/tokyonight.nvim" },
  { "catppuccin/nvim" },
  -- lazyvim.plugins.editor
  { "nvim-neo-tree/neo-tree.nvim" },
  { "windwp/nvim-spectre" },
  { "folke/which-key.nvim" },
  { "lewis6991/gitsigns.nvim" },
  { "echasnovski/mini.bufremove" },
  { "folke/trouble.nvim" },
  { "folke/todo-comments.nvim" },
  -- lazyvim.plugins.lsp
  { "neovim/nvim-lspconfig" },
  { "jose-elias-alvarez/null-ls.nvim" },
  { "williamboman/mason.nvim" },
  -- lazyvim.plugins.treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    ---@type TSConfig
    opts = { highlight = { enable = NOT_VSCODE } },
  },
  -- lazyvim.plugins.ui
  { "rcarriga/nvim-notify" },
  { "stevearc/dressing.nvim" },
  { "akinsho/bufferline.nvim" },
  { "nvim-lualine/lualine.nvim" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "echasnovski/mini.indentscope" },
  { "folke/noice.nvim" },
  { "goolord/alpha-nvim" },
  { "SmiteshP/nvim-navic" },
  { "nvim-tree/nvim-web-devicons" },
  { "MunifTanjim/nui.nvim" },
  -- lazyvim.plugins.utils
  { "dstein64/vim-startuptime" },
  { "folke/persistence.nvim" },
}

for _, name in ipairs(plugins) do
  if not NOT_VSCODE then
    name.enabled = false
  end
end

return plugins
