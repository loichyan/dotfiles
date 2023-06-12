if status is-interactive
    type -q lsd && alias ls lsd
    type -q lazygit && alias lg lazygit
    type -q safe-rm && alias rm 'safe-rm -I' || alias rm (printf '%s -I' (which rm))
end
