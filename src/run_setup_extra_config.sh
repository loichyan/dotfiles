#!/usr/bin/env bash

root=$(realpath "$CHEZMOI_SOURCE_DIR/..")

warn() {
  printf "\e[33m[WARN]\e[0m %s\n" "$1"
}

info() {
  printf "\e[36m[INFO]\e[0m %s\n" "$1"
}

symlink() {
  src="$root/$1"
  dest="$HOME/$2"

  if [ ! -e "$src" ]; then
    warn "Skip non-existent path '$src'"
    return
  elif [ -h "$dest" ]; then
    return
  elif [ -e "$dest" ]; then
    warn "Skip existing path '$dest'"
    return
  else
    info "Create symlink '$dest'"
  fi

  ln -s "$src" "$dest"
}

info "Setup extra configuration"

# symlink directories
symlink nvim .config/nvim
symlink wezterm .config/wezterm
symlink private/gpg .gnupg
symlink private/ssh .ssh

if [ ! -d "$HOME/.plum" ]; then
  info "Install rime/plum"
  git clone --depth 1 "https://github.com/rime/plum" ~/.plum
  mkdir -p ~/.local/bin
  ln -s ~/.plum/rime-install ~/.local/bin/rime-install
  info "Clone iDvel/rime-ice"
  bash ~/.plum/rime-install iDvel/rime-ice:others/recipes/full
fi
