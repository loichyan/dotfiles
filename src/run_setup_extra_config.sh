#!/usr/bin/env bash

set -e

root=$(cd "$(dirname "$CHEZMOI_SOURCE_DIR")" && pwd)
cd "$root"

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

tmux_base16_build() {
	info "build tmux-base16 template '$1' to '$2'"
	tmux run -E "#{@base16-build-palette} -i '#{@base16-templates}/$1' -o $2"
}

info "setup extra configuration"

# Symlink directories
symlink nvim .config/nvim
symlink tmux/plugins .tmux/plugins
symlink wezterm .config/wezterm
symlink private/gpg .gnupg
symlink private/ssh .ssh
if [[ -d private/config ]]; then
	for p in private/config/*; do
		f="$(basename "$p")"
		symlink "private/config/$f" ".config/$f"
	done
fi

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

mkdir -p "$HOME/.local/share/applications"
for f in com.visualstudio.code.desktop com.visualstudio.code-url-handler.desktop; do
	p="$HOME/.local/share/applications/$f"
	if [[ ! -f $p ]]; then continue; fi
	info "create '$p'"
	cp "/var/lib/flatpak/exports/share/applications/$f" "$p"
	sed "s|^Exec=/usr/bin/flatpak run .*com\.visualstudio\.code\(.*\)|Exec=$HOME/.local/bin/code\1|" -i "$p"
done

# Build terminal colors
if [[ -n $TMUX ]]; then
	tmux_base16_build alacritty.toml ~/.config/alacritty/colors.toml
	tmux_base16_build foot.ini ~/.config/foot/colors.ini
	tmux_base16_build kitty.conf ~/.config/kitty/colors.conf
	tmux_base16_build termux.properties ~/.termux/colors.properties
fi
