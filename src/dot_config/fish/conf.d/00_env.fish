if status is-login
    # Set default editor.
    set -gx EDITOR nvim
    set -gx VISUAL nvim

    # Define Python user base folder.
    set -gx PYTHONUSERBASE ~/.pip

    # iBus
    if ! isatty
        set -gx GTK_IM_MODULE ibus
        set -gx QT_IM_MODULE ibus
        set -gx XMODIFIERS @im=ibus
    end

    # Define Golang env variables
    set -gx GOPATH ~/.go
end

setproxy
