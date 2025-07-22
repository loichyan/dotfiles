#!/usr/bin/env bash

set -e

root="$(cd "$(dirname "$CHEZMOI_SOURCE_DIR")" && pwd)"

warn() {
	printf "\e[33m[WARN]\e[0m %s\n" "$1"
}

info() {
	printf "\e[36m[INFO]\e[0m %s\n" "$1"
}

has() {
	# shellcheck disable=SC2046
	return $(command -v "$1" &>/dev/null)
}

symlink() {
	src="$root/$1"
	dest="$HOME/$2"

	if [[ ! -e "$src" ]]; then
		warn "skip non-existent path '$src'"
	elif [[ -L "$dest" ]]; then
		info "skip existing symlink '$dest'"
	elif [[ -e "$dest" ]]; then
		warn "skip existing path '$dest'"
	else
		info "create symlink '$dest'"
		ln -sr -T "$src" "$dest"
	fi
}

copy_dir() {
	src="$root/$1"
	dest="$HOME/$2"

	info "copy '$src/*' into '$dest'"
	mkdir -p "$dest/"
	find "$src" -type f -exec cp {} "$dest/" \;
}

info "setup extra configuration"

# Symlink directories
symlink nvim .config/nvim
symlink wezterm .config/wezterm
symlink private/gpg .gnupg
symlink private/ssh .ssh
test -d private/config && find private/config -mindepth 1 | while read -r p; do
	f="$(basename "$p")"
	symlink "private/config/$f" ".config/$f"
done

# Copy extra files
copy_dir packages .config/home-manager/packages

# Install plum and mint
if has ibus && [[ ! -d "$HOME/.plum" ]]; then
	info "install rime/plum"
	git clone --depth 1 "https://github.com/rime/plum" ~/.plum
	info "install rime-mint"
	bash ~/.plum/rime-install Mintimate/oh-my-rime:plum/full
fi

# Create an empty Aria2 session file
if has aria2c; then
	mkdir -p ~/.local/share/aria2
	touch ~/.local/share/aria2/session
fi

# c.f. https://wiki.archlinux.org/title/GNOME/Keyring#Disabling
autostart="$HOME/.config/autostart"
sysfile="/etc/xdg/autostart/gnome-keyring-ssh.desktop"
userfile="$autostart/gnome-keyring-ssh.desktop"
if [[ -f "$sysfile" ]] && [[ ! -f "$userfile" ]]; then
	mkdir -p "$autostart/"
	cp "$sysfile" "$autostart/"
	echo "Hidden=true" >>"$userfile"
fi
