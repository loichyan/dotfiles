return {
  {
    "LuaSnip",
    -- jsregexp is installed by nixpkgs
    build = {},
    opts = {
      region_check_events = "InsertEnter",
      delete_check_events = "TextChanged",
    },
  },
  ----------------
  -- My plugins --
  ----------------
  {
    "junegunn/vim-easy-align",
    cmd = "EasyAlign",
  },
  {
    "max397574/better-escape.nvim",
    cond = NOT_VSCODE,
    opts = { mapping = { "jk", "jj" } },
    event = "InsertEnter",
  },
}
