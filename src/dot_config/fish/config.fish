if status is-interactive
    type -q zoxide && zoxide init fish | source
    type -q starship && starship init fish | source
end
