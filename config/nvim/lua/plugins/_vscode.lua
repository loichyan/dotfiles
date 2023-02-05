-- Disable some LazyVim plugins when running as the backend of VSCode.

local plugins = {
  -- lazyvim.plugins.coding
  { "LuaSnip" },
  { "nvim-cmp" },
  -- lazyvim.plugins.colorshceme
  { "tokyonight.nvim" },
  { "catppuccin/nvim", name = "catppuccin" },
  -- lazyvim.plugins.editor
  { "neo-tree.nvim" },
  { "nvim-spectre" },
  { "telescope.nvim" },
  { "which-key.nvim" },
  { "gitsigns.nvim" },
  { "mini.bufremove" },
  { "trouble.nvim" },
  { "todo-comments.nvim" },
  -- lazyvim.plugins.lsp
  { "nvim-lspconfig" },
  { "null-ls.nvim" },
  { "mason.nvim" },
  -- lazyvim.plugins.ui
  { "nvim-notify" },
  { "dressing.nvim" },
  { "bufferline.nvim" },
  { "lualine.nvim" },
  { "indent-blankline.nvim" },
  { "mini.indentscope" },
  { "noice.nvim" },
  { "alpha-nvim" },
  { "nvim-navic" },
  { "nvim-web-devicons" },
  { "nui.nvim" },
  -- lazyvim.plugins.utils
  { "vim-startuptime" },
  { "persistence.nvim" },
}

for _, name in ipairs(plugins) do
  if not NOT_VSCODE then
    name.cond = false
  end
end

---@diagnostic disable-next-line:missing-parameter
return vim.list_extend(plugins, {
  -- Disable some treesitter modules
  {
    "nvim-treesitter",
    opts = { highlight = { enable = NOT_VSCODE } },
  },
})
