function fish_user_key_bindings
    function fish_escape_insert_mode
        if commandline -P
            commandline -f cancel
        else
            set fish_bind_mode default
            commandline -f backward-char repaint-mode
        end
    end

    fish_vi_key_bindings
    fish_default_key_bindings -M insert
    bind -M insert \e fish_escape_insert_mode
    bind -M insert jk fish_escape_insert_mode
    bind -M insert \ce end-of-line
    bind -M insert \cw backward-kill-path-component
    bind -M insert \cb backward-kill-word
    bind -M insert \cf forward-bigword
    bind -M default yy fish_clipboard_copy
    bind -M default Y fish_clipboard_copy

    # Manually trigger events to force Fish to handle VI cursor in tmux.
    bind -M insert \ee 'edit_command_buffer; set fish_bind_mode $fish_bind_mode'
    bind -M insert \ev 'edit_command_buffer; set fish_bind_mode $fish_bind_mode'

    set -g fish_sequence_key_delay_ms 100
end
