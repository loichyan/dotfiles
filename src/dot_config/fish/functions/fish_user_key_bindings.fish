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

    if ! type -q atuin && type -q fzf
        function fzf-history-widget -d "Show command history"
            set -lx FZF_DEFAULT_OPTS "--height 50% $FZF_DEFAULT_OPTS --scheme=history --bind=ctrl-r:toggle-sort,ctrl-z:ignore +m"
            history -z | eval fzf --read0 --print0 -q '(commandline)' | read -lz result
            and commandline -- $result
            commandline -f repaint
        end
        bind -M insert \cr fzf-history-widget
    end

    set -g fish_sequence_key_delay_ms 100
end
