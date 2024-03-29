#!/usr/bin/env bash

colorscheme=catppuccin
catppuccin_style=frappe
tokyonight_style=storm

banner() {
  case "$colorscheme" in
  catppuccin)
    cat <<EOF
# Name:     Catppuccin ${catppuccin_style^}
# Author:   Catppuccin Org
# License:  MIT
# Upstream: https://github.com/catppuccin/$1
EOF
    ;;
  tokyonight)
    cat <<EOF
# Name:     Tokyo Night ${tokyonight_style^}
# Author:   Folke Lemaitre
# License:  MIT
# Upstream: https://github.com/folke/tokyonight.nvim
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
    curl -fsSL "https://github.com/catppuccin/kitty/raw/main/themes/$catppuccin_style.conf" | tail -n +11
    ;;
  tokyonight)
    curl -fsSL "https://github.com/folke/tokyonight.nvim/raw/main/extras/kitty/tokyonight_$tokyonight_style.conf" | tail -n +9
    ;;
  esac
} >src/dot_config/kitty/colorscheme.conf

# Tmux
{
  case "$colorscheme" in
  catppuccin)
    sed -e "s/\(set -g @catppuccin_flavour \)\".*\"/\1\"$catppuccin_style\"/" -i src/dot_tmux.conf
    ;;
  tokyonight)
    echo "Tokyo Night theme is not supported for Tmux" >&2
    ;;
  esac

}

# Yazi
{
  banner yazi
  case "$colorscheme" in
  catppuccin)
    curl -fsSL "https://github.com/catppuccin/yazi/raw/main/themes/${catppuccin_style}.toml"
    ;;
  tokyonight)
    echo "Tokyo Night theme is not supported for Yazi" >&2
    ;;
  esac
} >src/dot_config/yazi/theme.toml

# Delta
{
  banner delta
  case "$colorscheme" in
  catppuccin)
    curl -fsSL "https://github.com/catppuccin/delta/raw/main/catppuccin.gitconfig"
    sed -i -e "s/\(features =\) .*/\1 catppuccin-$catppuccin_style/" src/dot_config/git/config.tmpl
    ;;
  tokyonight)
    echo "Tokyo Night theme is not supported for Delta" >&2
    ;;
  esac
} >src/dot_config/git/catppuccin.gitconfig
