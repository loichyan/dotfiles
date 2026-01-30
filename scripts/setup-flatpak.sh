#!/usr/bin/env bash

set -euxo pipefail

# Gnome packages
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install \
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
	org.gnome.Showtime \
	org.gnome.Snapshot \
	org.gnome.TextEditor \
	org.gnome.Weather \
	org.gnome.baobab \
	org.gnome.clocks \
	org.gnome.font-viewer

# Additional packages
flatpak install \
	com.brave.Browser \
	com.github.tchx84.Flatseal \
	com.visualstudio.code \
	eu.betterbird.Betterbird \
	md.obsidian.Obsidian

# Share nixpkgs and fontconfig
flatpak override --user --filesystem=/nix:ro --filesystem=xdg-config/fontconfig:ro
