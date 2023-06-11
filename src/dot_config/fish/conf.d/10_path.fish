if ! status is-login
   return
end

# Setup environment variables for Nix and Home Manager.
set -l nix_profile ~/.nix-profile
for profile in \
    $nix_profile/etc/profile.d/nix.fish \
    $nix_profile/etc/profile.d/hm-session-vars.fish
    [ -f $profile ] && source $profile
end

# Vendor completions and functions
set -a fish_complete_path $nix_profile/share/fish/vendor_completions.d
set -a fish_function_path $nix_profile/share/fish/vendor_functions.d

# Local installed packages.
fish_add_path -p -g ~/.local/bin ~/.cargo/bin ~/.pip/bin ~/.pnpm/bin
