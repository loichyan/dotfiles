return {
  {
    "L3MON4D3/LuaSnip",
    opts = {
      history = false,
      region_check_events = "InsertEnter",
      delete_check_events = "InsertLeave",
    },
  },
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      ---@diagnostic disable-next-line:missing-parameter
      return vim.list_extend(keys, {
        { "gzr", false },
        { "gzc", desc = "Replace surrounding" },
      })
    end,
    opts = { mappings = { replace = "gzc" } },
  },
  ----------------
  -- My plugins --
  ----------------
  {
    "nacro90/numb.nvim",
    event = "CmdlineChanged",
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
  { "junegunn/vim-easy-align", cmd = "EasyAlign" }
}
