function history_delete -d "Delete history entries"
    if test -z "$argv" || ! argparse p/prefix=+ c/contains=+ -- $argv
        echo -n '\
USAGE:

history_delete [OPTION]...

OPTION:

-p/--prefix  Search histories by prefix
'
        return 1
    end

    function do_delete
        argparse atuin= fish= -- $argv
        or return 1

        if type -q atuin
            atuin search -f '{command}' --search-mode $_flag_atuin $argv
        else
            history search -C --$_flag_fish $argv
        end

        read -l -P "Confirm to delete? [Yes/no]" confirm
        switch (string lower $confirm)
            case y yes ''
                echo all | history delete -C --$_flag_fish $argv &>/dev/null
                if type -q atuin
                    atuin search --delete --search-mode $_flag_atuin $argv &>/dev/null
                end
        end
    end

    for text in $_flag_prefix
        do_delete --atuin=prefix --fish=prefix $text
    end

    for text in $_flag_contains
        do_delete --atuin=full-text --fish=contains $text
    end
end
