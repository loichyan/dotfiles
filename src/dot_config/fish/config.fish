if status is-interactive
    if set -q MY_PROXY_ENABLED
        setproxy $MY_HTTP_PROXY
    end
end
