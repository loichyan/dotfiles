local H = require("deltavim.helpers")
local Util = require("deltavim.util")

return {
  {
    "bufferline.nvim",
    opts = function(_, opts)
      return Util.merge({}, opts, {
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
      })
    end,
  },
  { "barbecue.nvim", opts = { theme = "catppuccin" } },
  {
    "lualine.nvim",
    opts = {
      options = {
        theme = "catppuccin",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
    },
  },
  {
    "alpha-nvim",
    ---@param opts DeltaVim.Config.Alpha
    opts = function(_, opts)
      table.insert(
        opts.buttons,
        3,
        { "p", "󱔗 ", "Find projects", H.telescope({ "project", "project" }) }
      )
    end,
  },
  {
    "indent-blankline.nvim",
    opts = {
      use_treesitter = true,
      show_current_context = true,
      show_first_indent_level = false,
      show_trailing_blankline_indent = false,
    },
  },
  { "mini.indentscope", enabled = false },
}
