if status is-interactive
    type -q lsd && alias ls lsd
    type -q lazygit && alias lg lazygit
    type -q safe-rm && alias rm safe-rm
    test "$TERM_PROGRAM" = WezTerm && alias nvim "TERM=wezterm nvim"
end
