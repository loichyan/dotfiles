if status is-interactive
    if type -q curl && echo exit | curl -s telnet://$MY_PROXY_ADDR
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
