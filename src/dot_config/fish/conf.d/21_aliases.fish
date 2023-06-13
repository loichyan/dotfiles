if status is-interactive
    function alias_command
        ! set -l cmd (type -fp $argv[2]) || alias $argv[1] "$cmd $argv[3..-1]"
    end

    alias_command ls lsd
    alias_command lg lazygit
    alias_command rm rm -I
    alias_command rm safe-rm -I
end
