#!/bin/sh

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
    warn "skip non-existent path '$src'"
    return
  elif [ -h "$dest" ]; then
    rm "$dest"
  elif [ -e "$dest" ]; then
    warn "skip existing path '$dest'"
    return
  fi

  ln -s "$src" "$dest"
  info "create symlink '$dest'"
}

symlink nvim .config/nvim
symlink private/ssh .ssh
