if [[ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish ]]; then
	. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# Load nix-direnv
for p in $NIX_PROFILES; do
	if [[ -f $p/etc/profile.d/hm-session-vars.sh ]]; then
		. "$p/etc/profile.d/hm-session-vars.sh"
	fi
done

# Search local installed binaries
p="$HOME/.local/bin:$HOME/.scripts:$HOME/.cargo/bin:$HOME/.pnpm/bin"
if [[ ! $PATH =~ $p ]]; then
	PATH="$p:$PATH"
fi

unset p
export PATH
