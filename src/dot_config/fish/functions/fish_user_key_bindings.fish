function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
    bind -M insert \cb backward-kill-word
    bind -M insert \cf forward-word
    bind -M insert JK (bind -M insert \e | string match -r '\'(.*)\'$')[2]

    if type -q fzf
        function fzf-history-widget -d "Show command history"
            set -lx FZF_DEFAULT_OPTS "--height 50% $FZF_DEFAULT_OPTS --scheme=history --bind=ctrl-r:toggle-sort,ctrl-z:ignore +m"
            history -z | eval fzf --read0 --print0 -q '(commandline)' | read -lz result
            and commandline -- $result
            commandline -f repaint
        end
        bind -M insert \cr fzf-history-widget
    end
end
