function setproxy
    set -f proxy ([ -n "$argv" ] && echo $argv[1] || echo $MY_HTTP_PROXY)
    set -gx HTTP_PROXY $proxy
    set -gx http_proxy $proxy
    set -gx HTTPS_PROXY $proxy
    set -gx https_proxy $proxy
end
