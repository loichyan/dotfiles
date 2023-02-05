local g = vim.g
local opt = vim.opt
local env = vim.env

-- Markdown highlight
g.markdown_fenced_languages = {
  "bash",
  "c",
  "json",
  "lua",
  "python",
  "rust",
  "sh",
}

-- Proxy environment variables
local my_http_proxy = vim.env.MY_HTTP_PROXY
env.http_proxy = my_http_proxy
env.HTTP_PROXY = my_http_proxy
env.https_proxy = my_http_proxy
env.HTTPS_PROXY = my_http_proxy

-- Clipboard
opt.clipboard = ""

-- GUI font
opt.guifont = "Fira Code:h11"
