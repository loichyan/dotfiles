if status is-interactive
    set -g __hist_protected $history
    set -g __hist_failed
    set -g __hist_deletions
    set -g __hist_last

    function ADD -d "Protect the last history"
        echo $__hist_last
        set -a __hist_protected $__hist_last
    end

    function DEL -d "Delete the last history"
        echo $__hist_last
        set -a __hist_deletions $__hist_last
    end

    function __hook_fish_postexec -e fish_postexec
        set -l hist $argv[1]
        set -l exitcode $status
        # Delete histories with ignored prefixes.
        if string match -qr '^(;|ADD|DEL|history |echo |printf ).*$' $hist
            set -a __hist_deletions $hist
            return
        end
        set -g __hist_last $hist
        if test "$exitcode" -eq 0
            set -a __hist_protected $hist
        else
            set -a __hist_failed $hist
        end
    end

    function __hook_fish_exit -e fish_exit
        for hist in $__hist_failed
            if ! contains $hist $__hist_protected
                set -a __hist_deletions $hist
            end
        end
        history delete -Ce '' $__hist_deletions
    end

    if type -q direnv
        set -g direnv_fish_mode eval_after_arrow
        direnv hook fish | source
    end
end
