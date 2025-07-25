#!/usr/bin/env bash

set -euxo pipefail

# Gnome packages
flatpak install -y \
	org.gnome.Calculator \
	org.gnome.Calendar \
	org.gnome.Characters \
	org.gnome.Connections \
	org.gnome.Contacts \
	org.gnome.Evince \
	org.gnome.Extensions \
	org.gnome.Logs \
	org.gnome.Loupe \
	org.gnome.Maps \
	org.gnome.NautilusPreviewer \
	org.gnome.Snapshot \
	org.gnome.TextEditor \
	org.gnome.Totem \
	org.gnome.Weather \
	org.gnome.baobab \
	org.gnome.clocks \
	org.gnome.font-viewer \
	org.mozilla.Thunderbird \
	com.github.tchx84.Flatseal

# Additional packages from Flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y app.zen_browser.zen md.obsidian.Obsidian

flatpak override --user --filesystem=/nix:ro --filesystem=xdg-config/fontconfig:ro
# Share Git configuration directory so that it can be recognized by obsidian-git
flatpak override --user --filesystem=xdg-config/git:ro md.obsidian.Obsidian
