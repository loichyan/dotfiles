if ! status is-interactive
    return
end

type -q lsd && alias ls lsd
type -q lazygit && alias lg lazygit
[ $TERM_PROGRAM = WezTerm ] && alias nvim "TERM=wezterm nvim"
