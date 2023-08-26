function setproxy
    set -f proxy (if [ -n "$argv" ]; echo $argv; else; echo $MY_SOCKS_PROXY; end)
    for v in {all,ftp,http,https}_proxy
        set -gx $v $proxy
        set -gx (string upper $v) $proxy
    end
end
