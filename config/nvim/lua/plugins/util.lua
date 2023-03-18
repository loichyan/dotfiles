local Util = require("deltavim.util")
local Keymap = require("deltavim.core.keymap")

return {
  { import = "deltavim.extras.util.smart_splits" },
  { "smart-splits.nvim", cond = NOT_VSCODE },
  ----------------
  -- My plugins --
  ----------------
  {
    "nacro90/numb.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = true,
  },
  {
    "tpope/vim-sleuth",
    cmd = "Sleuth",
    init = function()
      require("deltavim.util").autocmd("BufReadPost", "silent! Sleuth<CR>")
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    cond = NOT_VSCODE,
    event = "VeryLazy",
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
    cond = NOT_VSCODE,
    event = "VeryLazy",
  },
}
