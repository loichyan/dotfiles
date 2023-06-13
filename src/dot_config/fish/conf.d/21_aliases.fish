if status is-interactive
    function alias_command
        ! type -qf $argv[1] || alias $argv[1] "command $argv[2..-1]"
    end

    alias_command ls lsd
    alias_command lg lazygit
    alias_command rm rm -I
    alias_command rm safe-rm -I
end
