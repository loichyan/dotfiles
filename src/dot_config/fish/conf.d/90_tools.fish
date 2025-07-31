# Use GnuPG for SSH authorization
if not set -q __fish_did_init; and set -q MY_GPG_ENABLED; and type -q gpg
    # See <https://wiki.archlinux.org/title/GnuPG#SSH_agent>
    set -e SSH_AGENT_PID
    if test "$gnupg_SSH_AUTH_SOCK_BY" != $fish_pid
        set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    end
    # Start the gpg agent
    gpg-connect-agent -q /bye >/dev/null
end

# Interactive tools
if not status is-interactive
    return
end

if type -q atuin
    atuin init fish --disable-up-arrow | source
    if not set -q __atuin_daemon_started
        and not ps -oargs ax | string match -q 'atuin daemon'
        rm -f ~/.local/share/atuin/atuin.sock
        atuin daemon &>/dev/null & disown
        set -gx __atuin_daemon_started 1
    end
else if type -q fzf_key_bindings
    fzf_key_bindings
end

if type -q direnv
    set -g direnv_fish_mode eval_after_arrow
    direnv hook fish | source
end

if type -q zoxide
    zoxide init fish | source
end
