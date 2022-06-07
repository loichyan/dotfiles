# Remove duplicated entries in PATH.
typeset -U PATH

# Set term color.
export TERM=xterm-256color

# Set default editor.
export EDITOR=nvim
export VISUAL=nvim

# Setup environment variables for Nix.
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
if [[ -d /nix ]]; then
  for profile in "${(z)NIX_PROFILES}"; do
    # Load Homa Manger session variables.
    if [[ -f "$profile/etc/profile.d/hm-session-vars.sh" ]]; then
      source "$profile/etc/profile.d/hm-session-vars.sh"
    fi
    # Load zsh completions.
    fpath+=(
      "$profile/share/zsh/site-functions"
    )
  done
  unset profile
fi

# Prepend local installed packages to PATH.
path=(
  ~/.local/bin
  ~/.cargo/bin
  ~/.pnpm/bin
  $path
)
