#!/usr/bin/env bash

flavour=frappe

banner() {
  cat <<EOF
# Name:     Catppuccin ${flavour^}
# Author:   Catppuccin Org
# License:  MIT
# Upstream: https://github.com/catppuccin/$1

EOF
}

banner_xml() {
  cat <<EOF
<!--
 Name:     Catppuccin ${flavour^}
 Author:   Catppuccin Org
 License:  MIT
 Upstream: https://github.com/catppuccin/$1
-->

EOF
}

ghdown() {
  curl -fsSL "https://github.com/$1" "${@:2}"
}

# Neovim
{
  sed -e "s/\(flavour\) = \".*\"/\1 = \"$flavour\"/" -i nvim/lua/plugins/colorscheme.lua
}

# WezTerm
{
  sed -e "s/\(color_scheme\) = \".*\"/\1 = \"Catppuccin ${flavour^}\"/" -i wezterm/wezterm.lua
}

# Zellij
{
  sed -e "s/\(theme\) \".*\"/\1 \"catppuccin-$flavour\"/" -i src/dot_config/zellij/config.kdl
}

# Kitty
{
  banner kitty
  ghdown "catppuccin/kitty/raw/main/themes/$flavour.conf" | tail -n +11
} >src/dot_config/kitty/colorscheme.conf

# Tmux
{
  sed -e "s/\(set -g @catppuccin_flavour\) \".*\"/\1 \"$flavour\"/" -i src/dot_tmux.conf
}

# Yazi
{
  banner yazi
  ghdown "catppuccin/yazi/raw/main/themes/${flavour}.toml"
} >src/dot_config/yazi/theme.toml

# Delta
{
  banner delta
  ghdown "catppuccin/delta/raw/main/catppuccin.gitconfig"
} >src/dot_config/git/catppuccin.gitconfig

# Delta
{
  banner_xml delta
  ghdown "catppuccin/bat/raw/main/themes/Catppuccin%20${flavour^}.tmTheme"
} >src/dot_config/bat/themes/catppuccin.tmTheme
