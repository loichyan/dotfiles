#!/usr/bin/env bash

# TODO: manually generate colorscheme
colorscheme=catppuccin
catppuccin_style=frappe
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
  banner alacritty
  case "$colorscheme" in
  catppuccin)
    curl -fsSL https://raw.githubusercontent.com/catppuccin/alacritty/main/catppuccin-$catppuccin_style.yml
    ;;
  tokyonight)
    curl -fsSL https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/alacritty/tokyonight_$tokyonight_style.yml
    ;;
  esac
} >src/dot_config/alacritty/colorscheme.yml

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
  banner kitty
  case "$colorscheme" in
  catppuccin)
    curl -fsSL https://raw.githubusercontent.com/catppuccin/kitty/main/themes/$catppuccin_style.conf
    ;;
  tokyonight)
    curl -fsSL https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/kitty/tokyonight_$tokyonight_style.conf
    ;;
  esac
} >src/dot_config/kitty/colorscheme.conf

{
  echo -e "#!/usr/bin/env bash\n"
  banner https://github.com/catppuccin/tmux
  case "$colorscheme" in
  catppuccin)
    echo -e "# shellcheck disable=SC2034\n"
    curl -fsSL https://raw.githubusercontent.com/catppuccin/tmux/main/catppuccin-$catppuccin_style.tmuxtheme
    echo
    cat <<EOF
black="\$thm_bg"
white="\$thm_fg"
gray="\$thm_gray"
blue="\$thm_blue"
yellow="\$thm_yellow"
EOF
    ;;
  tokyonight)
    # TODO: get colors
    echo TODO
    ;;
  esac
} >src/dot_tmux/colorscheme.sh

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
} >wezterm/colorscheme.lua
