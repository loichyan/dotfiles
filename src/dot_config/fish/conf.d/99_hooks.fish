if status is-interactive
    set -g __history_protected $history
    set -g __history_failed
    set -g __history_deletions
    set -g history_ignored bat cat cd ch{con,grp,mod,own} cp echo l{s,l} math mv history printf rm string

    function ADD -d "Protected a history entry from deletion."
        echo $argv
    end

    function DEL -d "Delete a history from histories."
        echo $argv
    end


    function __hook_record_failures -e fish_postexec
        if set -l mat (string match -r '(ADD|DEL) (.+)' $argv[1])
            switch $mat[2]
                case ADD
                    set -a __history_protected $mat[3]
                case DEL
                    set -a __history_deletions $mat[3]
            end
        else if test $status -eq 0
            set -a __history_protected $argv[1]
        else
            set -a __history_failed $argv[1]
        end
    end

    function __hook_drop_histories -e fish_exit
        set -a history_ignored ADD DEL
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
