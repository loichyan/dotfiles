function man -d "man(1) with colors"
    # Stolen from <https://github.com/ohmyzsh/ohmyzsh/blob/5c804257ceb5b3062b876afae290adf72c474aad/plugins/colored-man-pages/colored-man-pages.plugin.zsh#L9>
    # bold & blinking mode
    set -lx LESS_TERMCAP_mb (set_color red -o)
    set -lx LESS_TERMCAP_md (set_color red -o)
    set -lx LESS_TERMCAP_me (set_color normal)
    # standout mode
    set -lx LESS_TERMCAP_so (set_color -b yellow black -o)
    set -lx LESS_TERMCAP_se (set_color normal)
    # underlining
    set -lx LESS_TERMCAP_us (set_color green -o)
    set -lx LESS_TERMCAP_ue (set_color normal)

    set -lx MANPAGER 'less -R'
    command man $argv
end
