local Colorscheme = require("custom.colorscheme")

return {
  { "tokyonight.nvim", opts = { style = Colorscheme.tokyonight_style } },
  { "catppuccin", opts = { flavour = Colorscheme.catppuccin_style } },
  -- Disable unused colorschemes
  { "tokyonight.nvim", enabled = false },
  { "EdenEast/nightfox.nvim", enabled = false },
}
