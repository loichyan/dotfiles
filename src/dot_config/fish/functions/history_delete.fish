function history_delete -d "Delete history entries"
    if test -z "$argv" || ! argparse prefix=+ -- $argv
        echo -n "\
USAGE:

history_delete [OPTION]...

OPTION:

-p/--prefix  Search histories by prefix
"
        return 1
    end

    for pref in $_flag_prefix
        echo all | history delete -C --prefix $pref
        if type -q atuin
            atuin search --delete --search-mode prefix $pref
        end
    end
end
