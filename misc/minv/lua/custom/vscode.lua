--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
function ____exports.setup_vscode(minv)
    if vim.g.vscode ~= nil then
        minv:update_keybindings({["normal.extra"] = {["$merge"] = {["<C-k>"] = {cmd = function()
            vim.fn.VSCodeNotify("keyboard-quickfix.openQuickFix")
        end}}}})
    end
end
return ____exports
