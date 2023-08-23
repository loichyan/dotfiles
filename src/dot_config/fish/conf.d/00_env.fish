if status is-login
    # Set default editor.
    set -gx EDITOR nvim
    set -gx VISUAL nvim

    # Define Python user base folder.
    set -gx PYTHONUSERBASE ~/.pip

    # iBus
    export GTK_IM_MODULE=xim
    export QT_IM_MODULE=xim
    export XMODIFIERS=@im=ibus

    # Define Golang env variables
    set -gx GOPATH ~/.go
end

setproxy
