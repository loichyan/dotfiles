local map = vim.keymap.set
local unmap = vim.keymap.del

-- Diable keymaps in VSCode
-- TODO: remap some keys in VSCode
if not NOT_VSCODE then
  local disabled = {
    -- Resize windows
    "<C-Up>",
    "<C-Down>",
    "<C-Left>",
    "<C-Right>",
    -- Move among buffers
    "<S-h>",
    "<S-l>",
    "[b",
    "]b",
    "<leader>`",
    "<leader>bb",
    -- Lazy
    "<leader>l",
    -- Lazygit
    "<leader>gg",
    "<leader>gG",
    -- Floating terminal
    "<leader>ft",
    "<leader>fT",
  }
  for _, key in ipairs(disabled) do
    unmap("n", key)
  end
  return
end

-- Silently move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("v", "<A-j>", "<cmd>m '>+1<cr>gv=gv", { desc = "Move down" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("v", "<A-k>", "<cmd>m '<-2<cr>gv=gv", { desc = "Move up" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })

-- Escape in insert mode
map("i", "jj", "<esc>")
map("i", "jk", "<esc>")
