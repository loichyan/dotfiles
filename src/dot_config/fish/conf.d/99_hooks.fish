if status is-interactive
    function __clean_history -e fish_exit
        echo all | history delete --prefix ';' >/dev/null
    end
end
