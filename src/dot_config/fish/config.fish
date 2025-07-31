if status is-interactive
    function __clean_history -e fish_exit
        echo all | history delete --prefix ';' >/dev/null
    end
end
if set -q MY_PROXY_ENABLED
    setproxy $MY_HTTP_PROXY
end

# Prevent duplicate initialization
set -gx __fish_did_init 1
