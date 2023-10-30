local Colorscheme = require("custom.colorscheme")

return {
  {
    "tokyonight.nvim",
    opts = {
      transparent = true,
      style = Colorscheme.tokyonight_style,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  { "catppuccin", opts = {
    flavour = Colorscheme.catppuccin_style,
    transparent_background = true,
  } },
}
