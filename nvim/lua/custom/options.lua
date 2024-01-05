local timeoutlen
if NOT_VSCODE then
  timeoutlen = 300
else
  timeoutlen = 500
end

return {
  g = {
    tex_flavor = "latex",
  },
  o = {
    clipboard = "unnamed",
    conceallevel = 0,
    guifont = "monospace:h11",
    swapfile = false,
    timeoutlen = timeoutlen,
  },
}
