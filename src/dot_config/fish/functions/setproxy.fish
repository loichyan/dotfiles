function setproxy -d "Set proxy variables"
    set -l proxy (if test -n "$argv"; echo $argv; else; echo $MY_HTTP_PROXY; end)
    for v in {all,ftp,http,https}_proxy
        set -gx $v $proxy
        set -gx (string upper $v) $proxy
    end

    # Don't proxy localhost requests
    set -gx no_proxy localhost,127.0.0.1,::1,0.0.0.0,::
    set -gx NO_PROXY $no_proxy
end
