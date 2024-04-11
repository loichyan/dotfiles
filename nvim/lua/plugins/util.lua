local Util = require("deltavim.util")
local Keymap = require("deltavim.core.keymap")

return {
  ----------------
  -- My plugins --
  ----------------
  {
    "direnv/direnv.vim",
    lazy = false,
    cond = NOT_VSCODE,
  },
  {
    "nacro90/numb.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = true,
  },
  {
    "nmac427/guess-indent.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "wakatime/vim-wakatime",
    cond = NOT_VSCODE,
    event = "VeryLazy",
  },
  {
    "mrjones2014/smart-splits.nvim",
    cond = NOT_VSCODE,
    -- build = "./kitty/install-kittens.bash",
    opts = {
      resize_mode = {
        quit_key = "q",
        silent = true,
      },
      multiplexer_integration = false,
    },
    keys = function()
      ---@param f string
      ---@param args? any
      local function cmd(f, args)
        return function()
          require("smart-splits")[f](args)
        end
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
          { "@smart_splits.resize_mode", cmd("start_resize_mode"), "Resize window right" },
        })
        :collect_lazy()
    end,
    config = true,
  },
  {
    "subnut/nvim-ghost.nvim",
    lazy = false,
    config = function()
      -- vim.api.nvim_create_augroup("nvim_ghost_user_autocommands", {})
      Util.autocmd("User", function()
        vim.bo.filetype = "markdown"
        vim.bo.textwidth = 0
      end, {
        pattern = "*.*",
        group = "nvim_ghost_user_autocommands",
      })
    end,
  },
  {
    "renerocksai/telekasten.nvim",
    cmd = "Telekasten",
    opts = {
      home = vim.fn.expand("~/Documents/zettelkasten"),
    },
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
}
