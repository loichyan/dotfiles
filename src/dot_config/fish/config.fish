set -gx __fish_did_init 1

if status is-interactive
    if test "$MY_PROXY_ENABLED" = true
        setproxy $MY_HTTP_PROXY
    end
    if type -q zoxide
        zoxide init fish | source
    end
    if type -q starship
        starship init fish | source
        enable_transience
    end
end
