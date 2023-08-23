if status is-interactive
    set -g __history_protected $history
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

    function __hook_fish_postexec -e fish_postexec
        set -l hist $argv[1]
        set -l exitcode $status
        # Ignore some commands
        if string match -qr '^(;|ADD|DEL|history |echo |printf ).*$' $hist
            set -a __history_deletions $hist
        else
            set -g __history_last $hist
        end
        if [ "$exitcode" = 0 ]
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
        history delete -Ce '' $__history_deletions
    end

    if type -q direnv
        set -g direnv_fish_mode eval_after_arrow
        direnv hook fish | source
    end
end
