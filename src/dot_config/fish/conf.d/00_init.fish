if not set -q __fish_did_init
    # setup environment variables for Nix and Home Manager
    set -gx NIX_PROFILE_HOME ~/.nix-profile
    for profile in \
        $NIX_PROFILE_HOME/etc/profile.d/nix.fish \
        $NIX_PROFILE_HOME/etc/profile.d/hm-session-vars.fish
        if test -f $profile
            source $profile
        end
    end

    # vendored completions and functions
    for p in (string split ' ' -- $NIX_PROFILES)
        set -gp fish_complete_path $p/share/fish/vendor_completions.d
        set -gp fish_function_path $p/share/fish/vendor_functions.d
    end

    # local installed packages
    fish_add_path -gp ~/.local/bin ~/.cargo/bin ~/.go/bin ~/.pip/bin ~/.pnpm/bin

    # set default editor
    set -gx EDITOR nvim
    set -gx VISUAL nvim

    # XDG base directories
    set -gx XDG_CONFIG_HOME ~/.config
    set -gx XDG_CACHE_HOME ~/.cache
    set -gx XDG_DATA_HOME ~/.local/share
    set -gx XDG_STATE_HOME ~/.local/state

    # set Python user base folder
    set -gx PYTHONUSERBASE ~/.pip
    # ripgrep config path
    set -gx RIPGREP_CONFIG_PATH ~/.config/ripgrep/ripgreprc
    # fzf options
    set -gx FZF_DEFAULT_OPTS "--color 16"
    # set default Golang module directory
    set -gx GOPATH ~/.go

    # prevent duplicate initialization
    set -gx __fish_did_init 1
end
