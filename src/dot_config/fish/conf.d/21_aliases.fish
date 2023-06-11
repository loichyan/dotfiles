if ! status is-interactive
    return
end

type -q lsd && alias ls lsd
type -q lazygit && alias lg lazygit
type -q safe-rm && alias rm safe-rm
[ $TERM_PROGRAM = WezTerm ] && alias nvim "TERM=wezterm nvim"
