# Setup environment variables for Nix and Home Manager.
for profile (
  ~/.nix-profile/etc/profile.d/nix.sh
  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
) do
  if [[ -f $profile ]]; then
    source $profile
  fi
done
unset profile

# Local installed packages.
path=(
  ~/.local/bin
  ~/.cargo/bin
  ~/.pip/bin
  ~/.pnpm/bin
  $path
)
