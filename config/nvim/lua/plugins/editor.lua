local Util = require("deltavim.util")

local function open_and_quit(state)
  local node = state.tree:get_node()
  state.commands["open_drop"](state)
  if not require("neo-tree.utils").is_expandable(node) then
    state.commands["close_window"](state)
  end
end

return {
  {
    "neo-tree.nvim",
    opts = {
      window = {
        mappings = { ["<cr>"] = open_and_quit },
      },
    },
  },
  {
    "which-key.nvim",
    opts = function(_, opts)
      return Util.merge({}, opts, {
        groups = {
          mode = { "n", "x" },
          ["["] = { name = "+prev" },
          ["]"] = { name = "+next" },
          ["g"] = { name = "+goto" },
          ["gz"] = { name = "+surround" },
          ["<Leader>b"] = { name = "+buffer" },
          ["<Leader>f"] = { name = "+find" },
          ["<Leader>g"] = { name = "+git" },
          ["<Leader>l"] = { name = "+lsp" },
          ["<Leader>n"] = { name = "+notify" },
          ["<Leader>q"] = { name = "+session" },
          ["<Leader>s"] = { name = "+search" },
          ["<Leader>u"] = { name = "+ui" },
          ["<Leader>w"] = { name = "+window" },
          ["<Leader>x"] = { name = "+quickfix" },
          ["<Leader><Tab>"] = { name = "+tab" },
        },
      })
    end,
  },
  {
    "gitsigns.nvim",
    opts = { current_line_blame = true },
  },
  ----------------
  -- My plugins --
  ----------------
  -- Add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function() require("telescope").load_extension("fzf") end,
    },
  },
}
