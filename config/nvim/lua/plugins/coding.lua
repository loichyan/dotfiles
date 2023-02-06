return {
  {
    "LuaSnip",
    opts = {
      history = false,
      region_check_events = "InsertEnter",
      delete_check_events = "InsertLeave",
    },
  },
  ----------------
  -- My plugins --
  ----------------
  {
    "nacro90/numb.nvim",
    event = "BufReadPost",
    opts = {},
    config = function(_, opts)
      require("numb").setup(opts)
    end,
  },
  {
    "tpope/vim-sleuth",
    event = "BufReadPost",
    config = function()
      vim.api.nvim_create_autocmd("BufReadPost", {
        command = "silent! Sleuth<cr>",
      })
    end,
  },
  { "junegunn/vim-easy-align", cmd = "EasyAlign" },
}
