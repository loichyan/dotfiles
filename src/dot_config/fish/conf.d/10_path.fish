if status is-login
    # Setup environment variables for Nix and Home Manager.
    for profile in \
        $NIX_PROFILE_HOME/etc/profile.d/nix.fish \
        $NIX_PROFILE_HOME/etc/profile.d/hm-session-vars.fish
        if test -f $profile
            source $profile
        end
    end

    # Local installed packages.
    fish_add_path -gp ~/.local/bin ~/.cargo/bin ~/.go/bin ~/.pip/bin ~/.pnpm/bin
end

if status is-interactive
    # Vendor completions and functions
    set -ga fish_complete_path $NIX_PROFILE_HOME/share/fish/vendor_completions.d
    set -ga fish_function_path $NIX_PROFILE_HOME/share/fish/vendor_functions.d
end
