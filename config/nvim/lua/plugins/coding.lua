local Util = require("deltavim.util")

return {
  {
    "nvim-cmp",
    opts = function(_, opts)
      return Util.merge({}, opts, {
        sources = require("cmp").config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "crates" },
          { name = "buffer" },
        }),
      })
    end,
  },
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
  {
    "max397574/better-escape.nvim",
    opts = { mapping = { "jk", "jj" } },
    event = "InsertEnter",
  },
}
