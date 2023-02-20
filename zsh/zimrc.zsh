#
# Modules
#

# Sets sane Zsh built-in environment options.
zmodule environment
# Provides handy git aliases and functions.
zmodule git
# Applies correct bindkeys for input events.
zmodule input
# Sets a custom terminal title.
zmodule termtitle
# Utility aliases and functions. Adds colour to ls, grep and less.
zmodule utility

#
# Completion
#

# Additional completion definitions for Zsh.
zmodule zsh-users/zsh-completions --fpath src
# Enables and configures smart and extensive tab completion.
zmodule completion

#
# Modules that must be initialized last
#

# Feature rich syntax highlighting for Zsh.
zmodule zdharma-continuum/fast-syntax-highlighting
# Fish-like history search (up arrow) for Zsh.
zmodule zsh-users/zsh-history-substring-search
# Fish-like autosuggestions for Zsh.
zmodule zsh-users/zsh-autosuggestions
# Improved Vi Mode
zmodule jeffreytse/zsh-vi-mode