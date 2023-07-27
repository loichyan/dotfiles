function setproxy
    set -f proxy (if [ -n "$argv" ]; echo $argv; else; echo $MY_HTTP_PROXY; end)
    set -gx HTTP_PROXY $proxy
    set -gx http_proxy $proxy
    set -gx HTTPS_PROXY $proxy
    set -gx https_proxy $proxy
end
