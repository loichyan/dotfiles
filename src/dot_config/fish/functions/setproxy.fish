function setproxy -d "Set proxy variables"
    set -l proxy $argv (if test -n "$argv"; echo $argv; else; echo $MY_HTTP_PROXY; end)
    for v in {all,ftp,http,https}_proxy
        set -gx $v $proxy
        set -gx (string upper $v) $proxy
    end
end
