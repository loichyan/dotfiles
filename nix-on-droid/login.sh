#!/bin/sh

# Set up nixpkgs on Termux.
# Credit:
#   - https://github.com/t184256/nix-in-termux/blob/da51335be9332dc83e036340e3562af3ddbe1bd2/nix-in-termux
#   - https://github.com/nix-community/nix-on-droid/blob/5d88ff2519e4952f8d22472b52c531bb5f1635fc/modules/environment/login/login.nix

CERT_FILE=etc/tls/cert.pem

die() {
	echo "$@" >&2
	exit 1
}

if [ -z "$PREFIX" ]; then
	die "\$PREFIX is unset"
fi
if [ ! -e "$PREFIX/$CERT_FILE" ]; then
	die "CA certificate is missing at: $PREFIX/$CERT_FILE"
fi
if ! PROOT=$(command -v proot); then
	die "proot is not installed"
fi

user=${USER:-$(id -un)}
user_id=$(id -u)
group=$(id -gn)
group_id=$(id -g)

# Provide /etc/{passwd,group} files, since many programs rely on them
passwd_file=$(mktemp)
cat >"$passwd_file" <<-EOF
	root:x:0:0:root:/root:/bin/bash
	${user}:x:${user_id}:${group_id}:${user}:$HOME:$SHELL
EOF
group_file=$(mktemp)
cat >"$group_file" <<-EOF
	root:x:0:
	${group}:x:${group_id}:${user}
EOF

mkdir -p "$PREFIX/nix"
mkdir -p "$PREFIX/tmp"
mkdir -p "$PREFIX/.l2s"

# Enable link2symlink, which is critical for git and nix
export PROOT_TMP_DIR="$PREFIX/tmp"
export PROOT_L2S_DIR="$PREFIX/.l2s"
# Tell nix where the certificate locates
export NIX_SSL_CERT_FILE="/$CERT_FILE"
export USER="$user"
# Suppress warnings of nix-gc
export GC_NPROCS=1
# Unset LD_* variables which make nix commands fail
unset LD_PRELOAD
unset LD_LIBRARY_PATH
# Common environment variables
export LANG="${LANG:-'C.UTF-8'}"
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export TMPDIR=/tmp

$PROOT \
	--bind="/:/host" \
	--bind="$PREFIX/nix:/nix" \
	--bind="$PREFIX/:/usr" \
	--bind="$PREFIX/etc:/etc" \
	--bind="$PREFIX/tmp:/tmp" \
	--bind="$PREFIX/tmp:/dev/shm" \
	--bind="$passwd_file:/etc/passwd" \
	--bind="$group_file:/etc/group" \
	--link2symlink \
	"${@:-$SHELL}"
