local MY_HTTP_PROXY = vim.env["MY_HTTP_PROXY"]
for _, k in ipairs({ "http_proxy", "https_proxy" }) do
  vim.env[k] = MY_HTTP_PROXY
  vim.env[k:upper()] = MY_HTTP_PROXY
end

return {
  config = {
    colorscheme = NOT_VSCODE and "tokyonight" or "habamax",
  },
  o = {
    clipboard = "",
    guifont = "Fira Code:h11",
  },
}
