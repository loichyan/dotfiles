#!/bin/sh

DISTRO_NAME=${DISTRO_NAME:-nix}
NIX_DIR=${NIX_DIR:-"$PREFIX/nix"}
mkdir -p "$NIX_DIR"

# See <https://github.com/termux/proot/issues/80#issuecomment-752388990>
kernel="\\$(uname -s)\\Termux\\$(uname -r)\\$(uname -v)\\$(uname -m)\\localdomain\\-1\\"
lang="C.UTF-8"
path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

if [ -z "$NO_DISTRO" ]; then
	exec proot-distro login "$DISTRO_NAME" \
		--kernel "$kernel" \
		--shared-tmp \
		--termux-home \
		--bind "$NIX_DIR:/nix" \
		--env LANG="$lang" \
		--env PATH="$path" \
		"$@"
fi

# Set up a minimal Nix environment on Termux.
# References:
#   - https://github.com/t184256/nix-in-termux/blob/da51335be9332dc83e036340e3562af3ddbe1bd2/nix-in-termux
#   - https://github.com/nix-community/nix-on-droid/blob/5d88ff2519e4952f8d22472b52c531bb5f1635fc/modules/environment/login/login.nix

cert_file=/etc/tls/cert.pem
user=${USER:-$(id -un)}
home="/home/$user"

# Unset LD_* variables which make nix commands fail
unset LD_PRELOAD
unset LD_LIBRARY_PATH

exec proot \
	--bind="/:/host" \
	--bind="$PREFIX/:/usr" \
	--bind="$PREFIX/bin:/bin!" \
	--bind="$PREFIX/etc:/etc!" \
	--bind="$PREFIX/tmp:/tmp" \
	--bind="$PREFIX/dev/shm:/dev/shm" \
	--bind="$NIX_DIR:/nix" \
	--bind="$HOME:$home" \
	--kill-on-exit \
	--link2symlink \
	--sysvipc \
	-L \
	--kernel-release="$kernel" \
	/usr/bin/env \
	NIX_SSL_CERT_FILE="$cert_file" \
	SSL_CERT_FILE="$cert_file" \
	LANG="$lang" \
	PATH="$path" \
	HOME="$home" \
	PS1="(proot) $PS1" \
	bash -l
