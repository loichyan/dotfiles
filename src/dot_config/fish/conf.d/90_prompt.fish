if status is-interactive && type -q starship
    function __starship_pre_prompt -e fish_prompt
        if set -q fish_private_mode
            set -gx starship_private_status '󰈉'
        else
            set -e starship_private_status
        end
    end
    starship init fish | source
    enable_transience
else if status is-interactive
    functions -e fish_mode_prompt

    function fish_prompt_prefix
        switch $fish_bind_mode
            case default
                set_color green
                echo '❮'
            case insert
                echo '❯'
            case replace_one
                set_color purple
                echo '❮'
            case replace
                set_color purple
                echo '❮'
            case visual
                set_color blue
                echo '❮'
        end
        set_color normal
    end

    function fish_prompt
        set -l last_status $status
        set -l normal (set_color normal)
        set -l status_color (set_color brgreen)

        # Display username when we're root
        set -l prompt_user
        if functions -q fish_is_root_user && fish_is_root_user
            set prompt_user (set_color $fish_color_user_root -o) $USER $normal ' in '
        end

        # ~/a/b/c/to/directory
        set -lx fish_prompt_pwd_full_dirs 2
        set -lx fish_prompt_pwd_dir_length 1
        set -l prompt_cwd (set_color $fish_color_cwd -o) (prompt_pwd) $normal

        # Display Git branch
        set -l prompt_vsc
        if set -l vsc_info (fish_vcs_prompt '%s')
            set prompt_vsc ' on ' (set_color brpurple -o) $vsc_info $normal
        end

        # Color the prompt in red on error
        set -l prompt_status
        if test $last_status -ne 0
            set status_color (set_color $fish_color_error -o)
            set prompt_status $status_color ' [' $last_status ']' $normal
        end

        # Display an indicator in private mode
        set -l prompt_priv_mode
        if set -q fish_private_mode
            set prompt_priv_mode (set_color yellow -o) '* ' $normal
        end

        echo -s \n $prompt_user $prompt_cwd $prompt_vsc $prompt_status
        echo -n -s $prompt_priv_mode $status_color (fish_prompt_prefix) ' '
    end
end
