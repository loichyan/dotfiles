if status is-interactive
    function __hook_fish_exit -e fish_exit
        echo all | history delete --prefix ';' >/dev/null
    end

    if type -q atuin
        atuin init fish | source
    end

    if type -q direnv
        set -g direnv_fish_mode eval_after_arrow
        direnv hook fish | source
    end
end
