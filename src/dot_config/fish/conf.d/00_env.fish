if status is-login
    # Set default editor.
    set -gx EDITOR nvim
    set -gx VISUAL nvim

    # Define python user base folder.
    set -gx PYTHONUSERBASE ~/.pip
end
