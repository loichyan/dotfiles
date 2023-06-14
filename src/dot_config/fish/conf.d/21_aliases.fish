if status is-interactive
    function alias_command
        argparse -N 2 p/prefix=+ s/suffix=+ -- $argv || return
        ! set -l cmd (type -fp $argv[2]) || alias $argv[1] "$_flag_prefix $cmd $_flag_suffix $argv[3..-1]"
    end

    alias_command ls lsd
    alias_command lg lazygit
    alias_command rm rm -- -I
    alias_command rm safe-rm -- -I
    [ "$TERM_PROGRAM" != WezTerm ] || alias_command nvim nvim -p TERM=wezterm
end
