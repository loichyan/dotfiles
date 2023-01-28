--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local minv = require("minv")
local ____plugins = require("custom.plugins")
local setup_plugins = ____plugins.setup_plugins
local ____lsp = require("custom.lsp")
local setup_lsp = ____lsp.setup_lsp
local ____vscode = require("custom.vscode")
local setup_vscode = ____vscode.setup_vscode
function ____exports.setup()
    minv.setup(function(minv)
        local not_vscode = vim.g.vscode == nil
        vim.env.http_proxy = vim.env.MY_HTTP_PROXY
        vim.env.HTTP_PROXY = vim.env.MY_HTTP_PROXY
        vim.env.https_proxy = vim.env.MY_HTTP_PROXY
        vim.env.HTTPS_PROXY = vim.env.MY_HTTP_PROXY
        setup_plugins(minv)
        setup_lsp(minv)
        setup_vscode(minv)
        local au = minv.autocmds
        au.auto_resize.enable = not_vscode
        au.close.enable = not_vscode
        au.format_on_save.enable = false
        au.trim_spaces.enable = not_vscode
        au.ruler.enable = not_vscode
        au.ruler.offsets = {rust = 80}
        minv.settings.o.clipboard = ""
        vim.o.guifont = "Fira Code:h11"
    end)
end
return ____exports
