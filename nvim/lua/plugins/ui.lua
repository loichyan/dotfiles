local H = require("deltavim.helpers")

return {
  {
    "nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
      },
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
    "dashboard-nvim",
    opts = function(_, opts)
      table.insert(opts.config.center, 3, {
        key = "p",
        icon = "󱔗",
        desc = "Find projects",
        action = H.telescope({ "project", "project" }),
      })
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
    cond = NOT_VSCODE,
    event = "VeryLazy",
    opts = {
      notification = {
        window = { winblend = 0 },
      },
    },
  },
}
