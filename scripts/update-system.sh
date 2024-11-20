#!/usr/bin/env bash

set -euxo pipfail

rpm-ostree upgrade &
flatpak update &

{
	env -C ~/.config/home-manager nix flake update
	home-manager switch --impure
} &

nvim --headless +'Lazy update' +q &

# Update tmux plugins
bash ~/.tmux/plugins/tpm/bin/update_plugins all
