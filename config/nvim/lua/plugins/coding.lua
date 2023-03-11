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
  {
    "mini.pairs",
    opts = {
      mappings = {
        ["'"] = {
          action = "closeopen",
          pair = "''",
          neigh_pattern = "[^%a\\&].",
          register = { cr = false },
        },
      },
    },
  },
  ----------------
  -- My plugins --
  ----------------
  { "junegunn/vim-easy-align", cmd = "EasyAlign" },
}
