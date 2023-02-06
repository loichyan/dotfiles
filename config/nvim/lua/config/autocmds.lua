local au = vim.api.nvim_create_autocmd

-- Trim tailing spaces
au("BufWritePre", { command = [[silent! s/\s+$//e]], pattern = "*" })

-- Rulers
local rulers = {
  rust = 80,
}
for ft, offset in pairs(rulers) do
  au("FileType", {
    callback = function()
      vim.opt_local.colorcolumn = tostring(offset)
    end,
    pattern = ft,
  })
end

-- Press `q` to force close a buffer
au("FileType", {
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close!<cr>", { buffer = event.buf, silent = true })
  end,
  pattern = {
    "git",
    "TelescopePrompt",
    "null-ls-info",
    "vim",
  },
})
