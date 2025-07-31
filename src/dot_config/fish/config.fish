if status is-interactive
    if set -q MY_PROXY_ENABLED
        setproxy $MY_HTTP_PROXY
    end

    if type -q atuin
        atuin init fish --disable-up-arrow | source
        if not set -q __atuin_daemon_started; and not ps -oargs x | string match -q 'atuin daemon'
            rm -f ~/.local/share/atuin/atuin.sock
            atuin daemon &>/dev/null & disown
            set -gx __atuin_daemon_started 1
        end
    end

    if type -q direnv
        set -g direnv_fish_mode eval_after_arrow
        direnv hook fish | source
    end

    if type -q zoxide
        zoxide init fish | source
    end
end

# Prevent duplicate initialization
set -gx __fish_did_init 1
