-- Disable some plugins when running as the backend of VSCode.

local Utils = require("deltavim.utils")

local plugins = {
  -- deltavim.plugins.coding
  { "LuaSnip" },
  { "nvim-cmp" },
  { "nvim-autopairs" },
  -- deltavim.plugins.colorshceme
  { "tokyonight.nvim" },
  { "catppuccin" },
  -- deltavim.plugins.editor
  { "neo-tree.nvim" },
  { "nvim-spectre" },
  { "telescope.nvim" },
  { "which-key.nvim" },
  { "gitsigns.nvim" },
  { "vim-illuminate" },
  { "mini.bufremove" },
  { "trouble.nvim" },
  { "todo-comments.nvim" },
  -- deltavim.plugins.lsp
  { "nvim-lspconfig" },
  { "null-ls.nvim" },
  { "mason.nvim" },
  -- deltavim.plugins.ui
  { "nvim-notify" },
  { "dressing.nvim" },
  { "bufferline.nvim" },
  { "barbecue.nvim" },
  { "lualine.nvim" },
  { "indent-blankline.nvim" },
  { "mini.indentscope" },
  { "noice.nvim" },
  { "alpha-nvim" },
  { "nvim-navic" },
  { "nvim-web-devicons" },
  { "nui.nvim" },
  -- deltavim.plugins.utils
  { "vim-startuptime" },
  { "persistence.nvim" },
}

for _, name in ipairs(plugins) do
  if not NOT_VSCODE then name.cond = false end
end

---@diagnostic disable-next-line:missing-parameter
return Utils.concat(plugins, {
  -- Disable some treesitter modules
  {
    "nvim-treesitter",
    opts = { highlight = { enable = NOT_VSCODE } },
  },
})
