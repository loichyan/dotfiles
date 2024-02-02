#!/usr/bin/env bash

set -e

root=$(realpath "$CHEZMOI_SOURCE_DIR/..")

warn() {
  printf "\e[33m[WARN]\e[0m %s\n" "$1"
}

info() {
  printf "\e[36m[INFO]\e[0m %s\n" "$1"
}

has() {
  return $(command -v "$1" &>/dev/null)
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

pnpm_add() {
  local pkg
  local -a to_install=()
  for pkg in "$@"; do
    if ! pnpm list -g | grep -F "$pkg" &>/dev/null; then
      to_install+=("$pkg")
    fi
  done
  if ((${#to_install[@]})); then
    info "Install ${to_install[*]}"
    pnpm install -g "${to_install[@]}"
  fi
}

info "Setup extra configuration"

# symlink directories
symlink nvim .config/nvim
symlink wezterm .config/wezterm
symlink private/gpg .gnupg
symlink private/ssh .ssh

# Install plum and rime-ice
if [[ ! -d "$HOME/.plum" ]]; then
  info "Install rime/plum"
  git clone --depth 1 "https://github.com/rime/plum" ~/.plum
  info "Clone iDvel/rime-ice"
  bash ~/.plum/rime-install iDvel/rime-ice:others/recipes/full
fi

# Add pnpm completions
if has pnpm && [[ ! -e ~/.config/tabtab/fish/pnpm.fish ]]; then
  pnpm install-completion fish
  pnpm_add @fsouza/prettierd czg
fi

# https://wiki.archlinux.org/title/GNOME/Keyring#Disabling
autostart="$HOME/.config/autostart"
sysconf="/etc/xdg/autostart/gnome-keyring-ssh.desktop"
userconf="$autostart/gnome-keyring-ssh.desktop"
if [[ -e "$sysconf" ]] && [[ ! -e "$userconf" ]]; then
  mkdir -p "$autostart/"
  cp "$sysconf" "$autostart/"
  echo "Hidden=true" >>"$userconf"
fi
