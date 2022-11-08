--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
function ____exports.setup()
    local req = require
    local npairs = req("nvim-autopairs")
    local cond = req("nvim-autopairs.conds")
    local Rule = req("nvim-autopairs.rule")
    npairs.setup({check_ts = true})
    npairs.add_rules({Rule("<", ">"):with_pair(cond.none()):with_move(function(opts)
        return opts.prev_char:match(">") ~= nil
    end):use_key(">")})
end
return ____exports
