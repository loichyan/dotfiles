if status is-interactive
    set -g __history_protected $history
    set -g __history_protected_this 0
    set -g __history_failed
    set -g __history_deletions
    set -g history_ignored bat cat cd ch{con,grp,mod,own} \
        cp echo l{s,l} mkdir mv history printf rm sudo

    function __hook_fish_preexec -e fish_preexec
        set -g __history_protected_this 0
    end

    function __hook_sigint -s SIGINT
        # Protect interrupted command.
        set -g __history_protected_this 1
    end

    function __hook_fish_postexec -e fish_postexec
        if [ "$status" = 0 ] || [ "$__history_protected_this" = 1 ]
            set -a __history_protected $argv[1]
        else
            set -a __history_failed $argv[1]
        end
    end

    function __hook_fish_exit -e fish_exit
        set -a __history_deletions $history_ignored
        for entry in $__history_failed
            if ! contains $entry $__history_protected
                set -a __history_deletions $entry
            end
        end
        if [ -n "$__history_deletions" ]
            history delete -Ce $__history_deletions
        end
        echo all | history delete -p ';' (printf '%s \n' $history_ignored) >/dev/null
    end

    if type -q direnv
        direnv hook fish | source
    end
end
