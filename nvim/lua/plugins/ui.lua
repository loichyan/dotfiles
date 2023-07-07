local H = require("deltavim.helpers")

return {
  {
    "bufferline.nvim",
    opts = function(_, opts)
      if COLORSCHEME == "catppuccin" then
        opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
      end
      return opts
    end,
  },
  { "barbecue.nvim", opts = { theme = COLORSCHEME } },
  {
    "lualine.nvim",
    opts = {
      options = {
        theme = COLORSCHEME,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
    },
  },
  {
    "alpha-nvim",
    ---@param opts DeltaVim.Config.Alpha
    opts = function(_, opts)
      table.insert(opts.buttons, 3, { "p", "󱔗 ", "Find projects", H.telescope({ "project", "project" }) })
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
  { "noice.nvim", enabled = false },
  ----------------
  -- My plugins --
  ----------------
  {
    "j-hui/fidget.nvim",
    -- TODO: switch back to main brach
    branch = "legacy",
    cond = NOT_VSCODE,
    event = "VeryLazy",
    opts = { window = { blend = 0 } },
  },
}
