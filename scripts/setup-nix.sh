#!/usr/bin/env bash
set -euxo pipefail

multiuser() {
	# Install Nix
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

	# Forward proxy variables
	# shellcheck disable=2154
	# TODO: remove this workaround if https://github.com/DeterminateSystems/nix-installer/issues/974 fixed
	cat <<-INI | sudo tee /etc/systemd/system/nix-daemon.service.d/override.conf
		[Service]
		Environment="http_proxy=$http_proxy"
		Environment="https_proxy=$https_proxy"
		Environment="no_proxy=$no_proxy"
	INI

	# Activate Home Manager
	nix run home-manager/master -- switch --impure

}

singleuser() {
	curl -L https://nixos.org/nix/install | sh -s -- --no-daemon --no-channel-add --no-modify-profile
}
