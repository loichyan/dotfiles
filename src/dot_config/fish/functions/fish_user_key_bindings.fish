function fish_user_key_bindings
    fish_vi_key_bindings
    set -l esc (bind -M insert \e | string match -r '\'(.*)\'$')[2]
    fish_default_key_bindings -M insert
    bind -M insert JJ "$esc"
    bind -M insert JK "$esc"
    bind -M insert \ce end-of-line
    bind -M insert \cw backward-kill-path-component
    bind -M insert \cb backward-kill-word
    bind -M insert \cf forward-bigword

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
