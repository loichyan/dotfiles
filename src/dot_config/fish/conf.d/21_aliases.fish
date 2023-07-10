if status is-interactive
    function alias_command
        ! set -l cmd (type -fp $argv[2]) || alias $argv[1] "$prefix $cmd $argv[3..]"
    end

    set -l prefix
    alias_command cp xcp
    alias_command du dust
    alias_command lg lazygit
    alias_command ls exa
    alias_command rm rm -I
    alias_command rm safe-rm -I
    [ "$TERM_PROGRAM" != WezTerm ] || set prefix 'TERM=wezterm'
    prefix=$prefix alias_command nvim nvim --listen /tmp/nvim-server.sock

    functions -e alias_command
end
