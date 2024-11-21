if not set -q __fish_did_init
    # Setup environment variables for Nix and Home Manager
    if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    end
    for p in (string split ' ' -- $NIX_PROFILES)
        if test -f $p/etc/profile.d/hm-session-vars.fish
            . $p/etc/profile.d/hm-session-vars.fish
        end
        # Add vendored completions and functions from Nixpkgs
        set -gp fish_complete_path $p/share/fish/vendor_completions.d
        set -gp fish_function_path $p/share/fish/vendor_functions.d
    end

    # Search local installed binaries
    fish_add_path -gp ~/.local/bin ~/.scripts ~/.cargo/bin ~/.pnpm/bin

    # Set default editor
    if type -q nvim
        set -gx EDITOR nvim
        set -gx VISUAL nvim
    end

    # Set XDG base directories
    set -gx XDG_CONFIG_HOME ~/.config
    set -gx XDG_CACHE_HOME ~/.cache
    set -gx XDG_DATA_HOME ~/.local/share
    set -gx XDG_STATE_HOME ~/.local/state

    # Set Python user base folder
    set -gx PYTHONUSERBASE ~/.pip
    # Set ripgrep config path
    set -gx RIPGREP_CONFIG_PATH ~/.config/ripgrep/ripgreprc
    # Export fzf options
    set -gx FZF_DEFAULT_OPTS "--color 16"
    # Set default Golang module directory
    set -gx GOPATH ~/.go

    # Prevent duplicate initialization
    set -gx __fish_did_init 1
end
