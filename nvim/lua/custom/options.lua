local timeoutlen
if NOT_VSCODE then
  timeoutlen = 300
else
  timeoutlen = 500
end

vim.filetype.add({ extension = { json = "jsonc" } })

return {
  g = {
    tex_flavor = "latex",
  },
  o = {
    clipboard = "unnamed",
    conceallevel = 0,
    -- Enable mode shapes, highlight, and blinking
    -- guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,"
    --   .. "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,"
    --   .. "sm:block-blinkwait175-blinkoff150-blinkon175",
    guifont = "monospace:h11",
    swapfile = false,
    timeoutlen = timeoutlen,
  },
}
