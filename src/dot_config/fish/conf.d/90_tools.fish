if status is-interactive
    if type -q atuin
        atuin init fish --disable-up-arrow | source
    end

    if type -q direnv
        set -g direnv_fish_mode eval_after_arrow
        direnv hook fish | source
    end

    if type -q zoxide
        zoxide init fish | source
    end
end
