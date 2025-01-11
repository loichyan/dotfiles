if status is-interactive
    # Disable greeting
    set -g fish_greeting

    # Make cursor distinct among modes
    fish_vi_cursor

    # Add vendored completions and functions from Nixpkgs
    for p in (string split ' ' -- $NIX_PROFILES)
        set -gp fish_complete_path $p/share/fish/vendor_completions.d
        set -gp fish_function_path $p/share/fish/vendor_functions.d
    end
end
