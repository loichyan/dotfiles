local map = vim.keymap.set

-- Escape in insert mode
map("i", "jj", "<esc>")
map("i", "jk", "<esc>")

-- Mappings in VSCode
if not NOT_VSCODE then
  map("n", "<leader>l", "<nop>")
end
