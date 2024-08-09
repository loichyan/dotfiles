function set_container_file -d "(Un)set container file labels"
    if ! argparse e/earse -- $argv
        echo -n "
USAGE:

set_container_file [-e/--earse] <files>...

OPTION:

-e/--earse            Clear labels
"
        return 1
    end

    if test -n "$_flag_earse"
        restorecon -vRF $argv
    else
        chcon -vRt container_file_t $argv
    end
end
