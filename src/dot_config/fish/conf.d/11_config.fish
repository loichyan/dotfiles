if status is-interactive
    # Disable greeting
    set -g fish_greeting

    # Make cursor distinct among modes
    set -g fish_vi_force_cursor 1
    set -g fish_cursor_default block
    set -g fish_cursor_insert line blink
    set -g fish_cursor_replace_one underscore
    set -g fish_cursor_replace underscore
    set -g fish_cursor_external line blink
    set -g fish_cursor_visual block

    # Add vendored completions and functions from Nixpkgs
    for p in (string split ' ' -- $NIX_PROFILES)
        set -gp fish_complete_path $p/share/fish/vendor_completions.d
        set -gp fish_function_path $p/share/fish/vendor_functions.d
    end
end
