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

    if type -q starship
        function __starship_pre_prompt -e fish_prompt
            if set -q fish_private_mode
                set -gx starship_private_status '󰈉'
            else
                set -e starship_private_status
            end
        end
        starship init fish | source
        enable_transience
    end
end
