#!/usr/bin/env bash

colorscheme=catppuccin
catppuccin_style=macchiato
tokyonight_style=storm

banner() {
  case "$colorscheme" in
  catppuccin)
    cat <<EOF
## Name:     Catppuccin ${catppuccin_style^}
## Author:   Catppuccin Org
## License:  MIT
## Upstream: https://github.com/catppuccin/$1
EOF
    ;;
  tokyonight)
    cat <<EOF
## Name:     Tokyo Night ${tokyonight_style^}
## Author:   Folke Lemaitre
## License:  MIT
## Upstream: https://github.com/folke/tokyonight.nvim
EOF
    ;;
  esac
  echo
}

{
  cat <<EOF
return {
  colorscheme = "$colorscheme",
  catppuccin_style = "$catppuccin_style",
  tokyonight_style = "$tokyonight_style",
}
EOF
} >nvim/lua/custom/colorscheme.lua

{
  case "$colorscheme" in
  catppuccin)
    cat <<EOF
return "Catppuccin ${catppuccin_style^}"
EOF
    ;;
  tokyonight)
    cat <<EOF
return "tokyonight_$tokyonight_style"
EOF
    ;;
  esac
} >wezterm/config/colorscheme.lua
