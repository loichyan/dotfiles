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

# Neovim
{
  cat <<EOF
return {
  colorscheme = "$colorscheme",
  catppuccin_style = "$catppuccin_style",
  tokyonight_style = "$tokyonight_style",
}
EOF
} >nvim/lua/custom/colorscheme.lua

# WezTerm
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

# Zellij
{
  case "$colorscheme" in
  catppuccin)
    t="catppuccin-$catppuccin_style"
    ;;
  tokyonight)
    t="tokyonight-$tokyonight_style"
    ;;
  esac
  sed -e "s/theme \".*\"/theme \"$t\"/" -i src/dot_config/zellij/config.kdl
}

# Kitty
{
  banner kitty
  case "$colorscheme" in
  catppuccin)
    t="Catppuccin-${catppuccin_style^}"
    ;;
  tokyonight)
    t="tokyo_night_$tokyonight_style"
    ;;
  esac
  kitten themes --dump-theme "$t"
} >src/dot_config/kitty/colorscheme.conf

# Tmux
{
  case "$colorscheme" in
  catppuccin)
    sed -e "s/\(set -g @catppuccin_flavour \)\".*\"/\1\"$catppuccin_style\"/" -i src/dot_tmux.conf
    ;;
  tokyonight)
    echo "Tokyonight theme is not supported for Tmux" >&2
    ;;
  esac

}
