if status is-interactive
    set -g __history_protected $history
    set -g __history_protected_this 0
    set -g __history_failed
    set -g __history_deletions
    set -g __history_last

    function ADD -d "Protect the last history"
        echo $__history_last
        set -a __history_protected $__history_last
    end

    function DEL -d "Delete the last history"
        echo $__history_last
        set -a __history_deletions $__history_last
    end

    function __hook_fish_preexec -e fish_preexec
        set -g __history_protected_this 0
    end

    function __hook_sigint -s SIGINT
        # Protect interrupted command.
        set -g __history_protected_this 1
    end

    function __hook_fish_postexec -e fish_postexec
        set -l hist $argv[1]
        # Ignore some commands
        if set -l mat (string match -r '^(;|ADD|DEL|echo ).*$' $hist)
            if [ "$mat[2]" = ";" ]
                echo $mat[2]
                set -a __history_deletions $hist
            end
        else
            set -g __history_last $hist
        end
        if [ "$status" = 0 ] || [ "$__history_protected_this" = 1 ]
            # Delete histories which match ignored prefix.
            set -a __history_protected $hist
        else
            set -a __history_failed $hist
        end
    end

    function __hook_fish_exit -e fish_exit
        for hist in $__history_failed
            if ! contains $hist $__history_protected
                set -a __history_deletions $hist
            end
        end
        history delete -Ce $__history_deletions
    end

    if type -q direnv
        direnv hook fish | source
    end
end
