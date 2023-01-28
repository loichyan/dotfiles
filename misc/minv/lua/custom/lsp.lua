--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local function disable_formatting(client)
    client.server_capabilities.documentFormattingProvider = false
end
function ____exports.setup_lsp(minv)
    minv:update_preset({
        lspconfig = {servers = {["$merge"] = {
            sumneko_lua = {},
            rust_analyzer = {settings = {["rust-analyzer"] = {checkOnSave = {command = "clippy"}}}},
            taplo = {},
            clangd = {},
            tsserver = {on_attach = function(client)
                disable_formatting(client)
            end},
            cssls = {on_attach = function(client)
                disable_formatting(client)
            end},
            rnix = {}
        }}},
        null_ls_sources = {formatters = {["$merge"] = {prettierd = {}, stylua = {}}}}
    })
end
return ____exports
