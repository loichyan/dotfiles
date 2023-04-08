local MY_HTTP_PROXY = vim.env["MY_HTTP_PROXY"]
for _, k in ipairs({ "http_proxy", "https_proxy" }) do
  vim.env[k] = MY_HTTP_PROXY
  vim.env[k:upper()] = MY_HTTP_PROXY
end

local timeoutlen
if NOT_VSCODE then
  timeoutlen = 300
else
  timeoutlen = 500
end

return {
  o = {
    timeoutlen = timeoutlen,
    clipboard = "",
    guifont = "monospace:h11",
    swapfile = false,
  },
}
