local Keymap = require("deltavim.core.keymap")

return {
  ----------------
  -- My plugins --
  ----------------
  { "direnv/direnv.vim", lazy = false },
  {
    "nacro90/numb.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = true,
  },
  {
    "tpope/vim-sleuth",
    cmd = "Sleuth",
    init = function()
      require("deltavim.utils").autocmd("BufReadPost", "silent! Sleuth<CR>")
    end,
  },
  {
    "roxma/vim-tmux-clipboard",
    cond = NOT_VSCODE,
    event = "VeryLazy",
  },
  {
    "wakatime/vim-wakatime",
    cond = NOT_VSCODE,
    event = "VeryLazy",
  },
  {
    "mrjones2014/smart-splits.nvim",
    cond = NOT_VSCODE,
    keys = function()
      ---@param f string
      ---@param args? any
      local function cmd(f, args)
        return function() require("smart-splits")[f](args) end
      end

      -- stylua: ignore
      return Keymap.Collector()
        :map({
          -- move
          { "@smart_splits.move_up", cmd("move_cursor_up"), "Goto up window" },
          { "@smart_splits.move_down", cmd("move_cursor_down"), "Goto down window" },
          { "@smart_splits.move_left", cmd("move_cursor_left"), "Goto left window" },
          { "@smart_splits.move_right", cmd("move_cursor_right"), "Goto right window" },
          -- resize
          { "@smart_splits.resize_up", cmd("resize_up"), "Resize window up" },
          { "@smart_splits.resize_down", cmd("resize_down"), "Resize window down" },
          { "@smart_splits.resize_left", cmd("resize_left"), "Resize window left" },
          { "@smart_splits.resize_right", cmd("resize_right"), "Resize window right" },
        })
        :collect_lazy()
    end,
    config = true,
  },
}
