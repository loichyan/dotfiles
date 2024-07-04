if status is-login
    # Set default editor.
    set -gx EDITOR nvim
    set -gx VISUAL nvim

    # XDG base directories
    set -gx XDG_CONFIG_HOME ~/.config
    set -gx XDG_CACHE_HOME ~/.cache
    set -gx XDG_DATA_HOME ~/.local/share
    set -gx XDG_STATE_HOME ~/.local/state

    # nix directories
    set -gx NIX_PROFILE_HOME ~/.nix-profile

    # Define Python user base folder.
    set -gx PYTHONUSERBASE ~/.pip

    # ripgrep
    set -gx RIPGREP_CONFIG_PATH ~/.config/ripgrep/ripgreprc

    set -gx FZF_DEFAULT_OPTS "
        --color 16
    "

    # Define Golang env variables
    set -gx GOPATH ~/.go
end
