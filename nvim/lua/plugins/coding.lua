local Config = require("deltavim.config")
local Util = require("deltavim.util")

return {
  {
    "nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      local comparator = cmp.config.compare
      local source_names = {
        buffer = "[BUF]",
        creates = "[CRATES]",
        luasnip = "[SNIP]",
        nvim_lsp = "[LSP]",
        path = "[PATH]",
      }
      local source_dups = {
        buffer = 1,
        luasnip = 1,
        nvim_lsp = 0,
        path = 1,
      }
      local icons = Config.icons.kinds
      return Util.merge({}, opts, {
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = function(entry, item)
            local source = entry.source.name
            local max_width = math.floor(vim.o.columns * 0.4)
            if #item.abbr > max_width then
              item.abbr = string.sub(item.abbr, 1, max_width) .. "..."
            end
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            item.menu = source_names[source]
            item.dup = source_dups[source] or 0
            return item
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "crates" },
          { name = "buffer" },
        }),
        sorting = {
          comparators = {
            function(a, b) return not comparator.order(a, b) end,
            comparator.recently_used,
          },
        },
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
