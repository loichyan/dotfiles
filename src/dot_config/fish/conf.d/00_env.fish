if ! status is-login
   return
end

# Set default editor.
set -gx EDITOR nvim
set -gx VISUAL nvim

# Define python user base folder.
set -gx PYTHONUSERBASE ~/.pip
