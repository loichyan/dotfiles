if status is-interactive
    type -q lsd && alias ls lsd
    type -q lazygit && alias lg lazygit
    type -q safe-rm && alias rm 'safe-rm -i' || alias rm (printf '%s -i' (which rm))
    type -q nvim && test "$TERM_PROGRAM" = WezTerm && alias nvim (printf 'TERM=wezterm %s' (which nvim))
end
