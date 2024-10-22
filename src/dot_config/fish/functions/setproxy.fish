function setproxy -d "Set proxy variables"
    if ! argparse -X1 e/earse -- $argv
        echo -n "
Usage:

  setproxy [OPTIONS] <PROXY_URL>

Options:

  -e/--earse  Clear proxy variables
"
        return 1
    end

    if test -n "$_flag_earse"
        for v in {all,ftp,http,https,no}_proxy
            set -e $v
            set -e (string upper $v)
        end
    else
        set -l proxy (test -n "$argv" && echo $argv || echo $MY_HTTP_PROXY)
        for v in {all,ftp,http,https}_proxy
            set -gx $v $proxy
            set -gx (string upper $v) $proxy
        end

        # Don't proxy localhost requests
        set -gx no_proxy localhost,127.0.0.1,::1,0.0.0.0,::
        set -gx NO_PROXY $no_proxy
    end
end
