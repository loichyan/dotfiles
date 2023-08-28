if status is-login
    # Set default editor.
    set -gx EDITOR nvim
    set -gx VISUAL nvim

    # Define Python user base folder.
    set -gx PYTHONUSERBASE ~/.pip

    # iBus
    if ! isatty
        set -gx GTK_IM_MODULE xim
        set -gx QT_IM_MODULE xim
        set -gx XMODIFIERS @im=ibus
    end

    # ripgrep
    set -gx RIPGREP_CONFIG_PATH ~/.config/ripgrep/ripgreprc

    set -gx FZF_DEFAULT_OPTS "
        --color 16
    "

    # Define Golang env variables
    set -gx GOPATH ~/.go
end
