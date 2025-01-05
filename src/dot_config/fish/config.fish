if status is-interactive
    if set -q PROXY_ENABLED
        setproxy $MY_HTTP_PROXY
    end
end
