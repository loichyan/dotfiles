function setproxy
    argparse -X 1 -- $argv
    set -l proxy
    if [ -n "$argv" ]
        set proxy $argv
    else
        set proxy $MY_HTTP_PROXY
    end
    set -gx HTTP_PROXY $proxy
    set -gx http_proxy $proxy
    set -gx HTTPS_PROXY $proxy
    set -gx https_proxy $proxy
end
