if set -q __fish_did_init
    return
end

# Load environment variables of Nix
for f in /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish ~/.nix-profile/etc/profile.d/nix.fish
    if test -f $f
        . $f
        break
    end
end
# Load session variables of Homee Manager
for p in (string split ' ' -- $NIX_PROFILES)
    if test -f $p/etc/profile.d/hm-session-vars.fish
        . $p/etc/profile.d/hm-session-vars.fish
    end
end

# Search local installed binaries
fish_add_path -gp ~/.local/bin ~/.scripts ~/.cargo/bin ~/.pnpm/bin

# Set the default editor
if type -q nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
else if type -q vim
    set -gx EDITOR vim
    set -gx VISUAL vim
else if type -q vi
    set -gx EDITOR vi
    set -gx VISUAL vi
end

# Set the default pager
set -gx PAGER 'less -R'

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
