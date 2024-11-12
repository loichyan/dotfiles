function set_container_file -d "Set container file labels"
    if ! argparse e/earse -- $argv
        echo -n "
Usage:

  set_container_file [OPTIONS] <FILE>...

Options:

  -e/--earse  Clear labels
"
        return 1
    end

    if test -n "$_flag_earse"
        restorecon -vRF $argv
    else
        chcon -vRt container_file_t $argv
    end
end
