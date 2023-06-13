function setproxy
    if [ -n "$argv" ]
        set -f proxy $argv[1]
    else
        set -f proxy $MY_HTTP_PROXY
    end
    set -gx HTTP_PROXY $proxy
    set -gx http_proxy $proxy
    set -gx HTTPS_PROXY $proxy
    set -gx https_proxy $proxy
end
