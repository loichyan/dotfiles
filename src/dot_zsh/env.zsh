# Remove duplicated entries in PATH.
typeset -U PATH path

# Set default editor.
export EDITOR=nvim
export VISUAL=nvim

# Define python user base folder.
export PYTHONUSERBASE=~/.pip

# Setup environment variables for Nix and Home Manager.
for profile (
  ~/.nix-profile/etc/profile.d/nix.sh
  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
) do
  if [[ -e $profile ]]; then
    source $profile
  fi
done
unset profile

# Language specified packages.
declare -A local_path=(
  [cargo]=~/.cargo/bin
  [pip]=~/.pip/bin
  [pnpm]=~/.pnpm/bin
)
for k v in ${(kv)local_path}; do
  if (( ${+commands[$k]} )); then
    path=( $v $path )
  fi
done
unset local_path k v

# Local installed packages.
path=( ~/.local/bin $path )
