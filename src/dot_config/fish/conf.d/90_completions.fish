if ! status is-interactive
    return
end

type -q cue && cue completion fish | source
type -q pip && pip completion --fish | source
[ -f ~/.config/tabtab/fish/__tabtab.fish ] && . ~/.config/tabtab/fish/__tabtab.fish
