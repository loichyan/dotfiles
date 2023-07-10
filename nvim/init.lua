local Colorscheme = require("custom.colorscheme")
if Colorscheme.colorscheme == "nightfox" then
  COLORSCHEME = Colorscheme.nightfox_style
else
  COLORSCHEME = Colorscheme.colorscheme
end
NOT_VSCODE = not vim.g.vscode

-- Bootstrap DeltaVim
require("custom.lazy")
