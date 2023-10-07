local H = require("deltavim.helpers")

return {
  {
    "nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
  {
    "lualine.nvim",
    opts = {
      options = {
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
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      scope = {
        enabled = true,
        -- include = { node_type = { ["*"] = { "*" } } },
        show_start = false,
        show_end = false,
      },
    },
    config = function(_, opts)
      require("ibl").setup(opts)
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
    end,
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
