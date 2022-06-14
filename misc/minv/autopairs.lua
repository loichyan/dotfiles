local M = {}

function M.setup()
  local nparis = require("nvim-autopairs")
  local cond = require("nvim-autopairs.conds")
  local Rule = require("nvim-autopairs.rule")
  nparis.setup({ check_ts = true })
  nparis.add_rules({
    Rule("<", ">")
      :with_pair(cond.none())
      :with_move(function(opts)
        return opts.prev_char:match(">") ~= nil
      end)
      :use_key(">"),
  })
end

return M
