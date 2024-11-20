if status is-interactive
    # Disable greeting
    set -g fish_greeting

    # Make cursor distinct among modes
    set -g fish_vi_force_cursor 1
    set -g fish_cursor_default block
    set -g fish_cursor_insert line blink
    set -g fish_cursor_visual block
    set -g fish_cursor_replace_one underscore
end
