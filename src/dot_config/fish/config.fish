if status is-interactive
    setproxy $MY_HTTP_PROXY
    if type -q zoxide
        zoxide init fish | source
    end
    if type -q starship
        starship init fish | source
    end
end
