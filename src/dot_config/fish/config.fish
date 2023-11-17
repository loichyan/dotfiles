if status is-interactive
    if echo exit | curl -s telnet://$MY_HTTP_PROXY_ADDR
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
