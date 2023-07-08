#!/usr/bin/env bash

catppuccin_flavour=frappe

catppuccin_banner() {
  cat <<EOF
## Name:     Catppuccin ${catppuccin_flavour^}
## Author:   Catppuccin Org
## License:  MIT
## Upstream: $1

EOF
}

{
  catppuccin_banner https://github.com/catppuccin/alacritty
  curl -fsSL https://raw.githubusercontent.com/catppuccin/alacritty/main/catppuccin-$catppuccin_flavour.yml
} >src/dot_config/alacritty/catppuccin.yml

{
  catppuccin_banner https://github.com/catppuccin/kitty
  curl -fsSL https://raw.githubusercontent.com/catppuccin/kitty/main/themes/$catppuccin_flavour.conf | tail -n +11
} >src/dot_config/kitty/catppuccin.conf

{
  echo -e "#!/usr/bin/env bash\n"
  catppuccin_banner https://github.com/catppuccin/tmux
  echo -e "# shellcheck disable=SC2034\n"
  curl -fsSL https://raw.githubusercontent.com/catppuccin/tmux/main/catppuccin-$catppuccin_flavour.tmuxtheme | tail -n +5
  # shellcheck disable=SC2016
  cat <<EOF

black="\$thm_bg"
white="\$thm_fg"
gray="\$thm_gray"
blue="\$thm_blue"
yellow="\$thm_yellow"
EOF
} >src/dot_tmux/catppuccin.sh
