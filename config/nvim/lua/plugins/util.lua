local Util = require("deltavim.util")
local Keymap = require("deltavim.core.keymap")

return {
  { import = "deltavim.extras.util.smart_splits" },
  ----------------
  -- My plugins --
  ----------------
  {
    "nacro90/numb.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    config = function(_, opts) require("numb").setup(opts) end,
  },
  {
    "tpope/vim-sleuth",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("deltavim.util").autocmd("BufReadPost", "silent! Sleuth<CR>")
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {},
    keys = function()
      -- stylua: ignore
      return Keymap.Collector()
        :map({
          { "@search.projects", Util.telescope({ "projects" }), "Projects" },
        })
        :collect_lazy()
    end,
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension("projects")
    end,
  },
  {
    "roxma/vim-tmux-clipboard",
    event = "VeryLazy",
  },
}
