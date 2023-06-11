if ! status is-interactive
    return
end

# Theme and prompt
fish_config theme choose base16
type -q starship && starship init fish | source
