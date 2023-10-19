if status is-interactive
    function alias_command
        if set -l cmd (type -fp $argv[2])
            alias $argv[1] "$prefix $cmd $argv[3..]"
        end
    end

    alias_command cat bat
    alias_command du dust --no-percent-bars --reverse
    alias_command imgcat wezterm imgcat
    alias_command lg lazygit
    alias_command ls eza
    alias_command rm rm -I

    if test -x /usr/bin/bash
        alias bash /usr/bin/bash
    end

    if test "$TERM_PROGRAM" = WezTerm
        prefix='TERM=wezterm' alias_command nvim nvim
    end

    if ! type -q docker
        alias_command docker podman
    end

    if ! type -q docker-compose
        alias docker-compose \
            (if type -q podman-compose; echo podman-compose; else; echo docker compose; end)
    end

    functions -e alias_command
end
