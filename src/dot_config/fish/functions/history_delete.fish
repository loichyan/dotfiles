function history_delete -d "Delete history entries"
    if test -z "$argv" || ! argparse prefix=+ -- $argv
        echo -n '\
USAGE:

history_delete [OPTION]...

OPTION:

-p/--prefix  Search histories by prefix
'
        return 1
    end

    for pref in $_flag_prefix
        if type -q atuin
            atuin search -f '{command}' --search-mode prefix $pref
        else
            history search -C --prefix $pref
        end

        read -l -P "Confirm to delete? [Yes/no]" confirm
        switch (string lower $confirm)
            case y yes ''
                echo all | history delete -C --prefix $pref &>/dev/null
                if type -q atuin
                    atuin search --delete --search-mode prefix $pref &>/dev/null
                end
        end
    end
end
