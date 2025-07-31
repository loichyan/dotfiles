if not set -q __fish_did_init; and set -q MY_GPG_ENABLED; and type -q gpg
    # See <https://wiki.archlinux.org/title/GnuPG#SSH_agent>
    set -e SSH_AGENT_PID
    if test "$gnupg_SSH_AUTH_SOCK_BY" != $fish_pid
        set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    end
    # Start the gpg agent
    gpg-connect-agent -q /bye >/dev/null
end
