if not status is-interactive
    return
end

if type -q starship
    function __starship_pre_prompt -e fish_prompt
        if set -q fish_private_mode
            set -gx starship_private_status '󰈉'
        else
            set -e starship_private_status
        end
    end
    function starship_transient_prompt_func
        starship module character
    end
    starship init fish | source
    enable_transience
    return
end

functions -e fish_mode_prompt

function fish_prompt_prefix
    switch $fish_bind_mode
        case default
            echo '❮'
        case insert
            # Color is set by $status_color
            echo '❯'
        case replace_one
            set_color magenta
            echo '❮'
        case replace
            set_color magenta
            echo '❮'
        case visual
            set_color yellow
            echo '❮'
    end
end

function fish_prompt
    set -l last_status $status
    set -l normal (set_color normal)
    set -l status_color (set_color green)

    # Display username anyway when we're root;
    # otherwise display it only if explicitly enabled.
    set -l prompt_user
    if functions -q fish_is_root_user; and fish_is_root_user
        set prompt_user (set_color $fish_color_user_root -o) $USER $normal '@' \
            (set_color $fish_color_host -o) (prompt_hostname) $normal ' in '
    else if set -q PROMPT_SHOW_USER
        set prompt_user (set_color $fish_color_user -o) $USER $normal '@' \
            (set_color $fish_color_host -o) (prompt_hostname) $normal ' in '
    end

    # ~/a/b/c/to/directory
    set -lx fish_prompt_pwd_full_dirs 2
    set -lx fish_prompt_pwd_dir_length 1
    set -l prompt_cwd (set_color $fish_color_cwd -o) (prompt_pwd) $normal

    # Display virtual env
    set -l prompt_venv
    if set -q VIRTUAL_ENV
        set -l venv_info (path basename $VIRTUAL_ENV)
        set prompt_venv ' via ' (set_color yellow -o) "($venv_info)" $normal
    end

    # Display Git branch
    set -l prompt_vsc
    if set -l vsc_info (fish_vcs_prompt '%s')
        set prompt_vsc ' on ' (set_color brmagenta -o) $vsc_info $normal
    end

    # Color the prompt in red on error
    set -l prompt_status
    if test "$last_status" -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status $status_color ' [' $last_status ']' $normal
    end

    # Display an indicator in private mode
    set -l prompt_priv_mode
    if set -q fish_private_mode
        set prompt_priv_mode (set_color yellow -o) '* ' $normal
    end

    echo -s \n $prompt_user $prompt_cwd $prompt_venv $prompt_vsc $prompt_status
    echo -n -s $prompt_priv_mode $status_color (fish_prompt_prefix) $normal ' '
end

# Disable as it breaks out prompt
set -g VIRTUAL_ENV_DISABLE_PROMPT 1
