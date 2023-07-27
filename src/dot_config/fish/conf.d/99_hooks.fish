if status is-interactive
    set -g __history_successes $history
    set -g __history_failures
    set -g history_ignore_commands bat cat cd ch{con,grp,mod,own} cp echo l{s,l} math mv history printf rm string

    function __hook_record_failures -e fish_postexec
        if test $status -eq 0
            set -a __history_successes $argv[1]
        else
            set -a __history_failures $argv[1]
        end
    end

    function __hook_drop_histories -e fish_exit
        set -l entries $history_ignore_commands
        for c in $__history_failures
            if ! contains $c $__history_successes
                set -a entries $c
            end
        end
        if [ -n "$entries" ]
            history delete -Ce $entries
        end
        echo all | history delete -p ';' (printf '%s \n' $history_ignore_commands) >/dev/null
    end

    if type -q direnv
        direnv hook fish | source
    end
end
