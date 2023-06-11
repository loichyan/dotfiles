if ! status is-interactive
    return
end

set -g __failures

function __hook_record_failures -e fish_postexec
    if [ $status -ne 0 ]
        set -a __failures "$argv[1]"
    end
end

function __hook_drop_histories -e fish_exit
    if [ -n "$__failures" ]
        history delete -C -e $__failures
    end
end

type -q direnv && direnv hook fish | source
type -q zoxide && zoxide init fish | source
