if status is-interactive
    set -g __history_failures
    set -g history_ignore_commands bat cat cd ch{con,grp,mod,own} cp echo l{s,l} math mv history printf rm string

    function __hook_record_failures -e fish_postexec
        if test $status -ne 0
            set -a __history_failures $argv[1]
        end
    end

    function __hook_drop_histories -e fish_exit
        if test -n "$__history_failures"
            history delete -C -e $__history_failures
        end
        echo all | history delete -p ';' (printf '%s \n' $history_ignore_commands) >/dev/null
    end

    type -q direnv && direnv hook fish | source
end
