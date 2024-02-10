if status is-interactive
    set -g __hist_ignored '^(;|ADD|DEL|cat|cd|cp|echo|history|ll|ls|mkdir|mv|printf|rm|sudo).*'
    set -g __hist_protected $history
    set -g __hist_failed
    set -g __hist_deletions
    set -g __hist
    set -g __hist_last

    function ADD -d "Protect a history"
        set -l hist (string sub -s 5 $__hist)
        if test -z "$hist"
            set -a __hist_protected $__hist_last
        else
            set -a __hist_protected $hist
            return 0
        end
    end

    function DEL -d "Delete a history"
        set -l hist (string sub -s 5 $__hist)
        if test -z "$hist"
            set -a __hist_deletions $__hist_last
        else
            set -a __hist_deletions $hist
            return 0
        end
    end

    function __hook_fish_preexec -e fish_preexec
        set __hist (string trim $argv[1] | string collect --allow-empty)
    end

    function __hook_fish_postexec -e fish_postexec
        set -l exitcode $status
        set __hist_last $__hist
        if test "$exitcode" = 0 && ! string match -qr $__hist_ignored $__hist
            set -a __hist_protected $__hist
        else
            set -a __hist_failed $__hist
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
