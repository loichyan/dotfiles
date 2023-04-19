local Utils = require("deltavim.utils")

return {
  {
    "nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      local o = Utils.deep_merge({}, opts, {
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer", keyword_length = 3 },
          { name = "path", keyword_length = 3 },
          { name = "crates" },
        }),
      })
      return o
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
