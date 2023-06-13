set -l nix_profile ~/.nix-profile

if status is-login
    # Setup environment variables for Nix and Home Manager.
    for profile in \
        $nix_profile/etc/profile.d/nix.fish \
        $nix_profile/etc/profile.d/hm-session-vars.fish
        [ ! -f $profile ] || source $profile
    end

    # Local installed packages.
    fish_add_path -gp ~/.local/bin ~/.cargo/bin ~/.pip/bin ~/.pnpm/bin
end

if status is-interactive
    # Vendor completions and functions
    set -ga fish_complete_path $nix_profile/share/fish/vendor_completions.d
    set -ga fish_function_path $nix_profile/share/fish/vendor_functions.d
end
