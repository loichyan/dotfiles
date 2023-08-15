if status is-login
    # Set default editor.
    set -gx EDITOR nvim
    set -gx VISUAL nvim

    # Define Python user base folder.
    set -gx PYTHONUSERBASE ~/.pip

    # Define Golang env variables
    set -gx GOPATH ~/.go
end
