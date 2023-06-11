if ! status is-interactive
    return
end

# No greeting
set -g fish_greeting

# Cursor style
set -g fish_vi_force_cursor 1
set -g fish_cursor_default block
set -g fish_cursor_insert line blink
set -g fish_cursor_visual block
set -g fish_cursor_replace_one underscore
