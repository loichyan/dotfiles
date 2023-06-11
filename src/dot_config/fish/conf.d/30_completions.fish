if status is-interactive
    type -q cue && cue completion fish | source
    type -q pip && pip completion --fish | source
    test -f ~/.config/tabtab/fish/__tabtab.fish && . ~/.config/tabtab/fish/__tabtab.fish
end
