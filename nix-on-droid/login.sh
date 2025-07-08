#!/bin/sh

DISTRO_NAME=${DISTRO_NAME:-nix}
NIX_DIR=${NIX_DIR:-"$PREFIX/nix"}
mkdir -p "$NIX_DIR"

# See <https://github.com/termux/proot/issues/80#issuecomment-752388990>
kernel="\\$(uname -s)\\Termux\\$(uname -r)\\$(uname -v)\\$(uname -m)\\localdomain\\-1\\"

exec proot-distro login "$DISTRO_NAME" \
	--kernel "$kernel" \
	--shared-tmp \
	--termux-home \
	--bind "$NIX_DIR:/nix" \
	"$@"
