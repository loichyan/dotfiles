if set -q MY_GPG_ENABLED && type -q gpg
    # Taken from https://wiki.archlinux.org/title/GnuPG#SSH_agent
    set -e SSH_AGENT_PID
    if test "$gnupg_SSH_AUTH_SOCK_BY" != $fish_pid
        set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    end

    # Configure pinentry to use the correct TTTY
    set -gx GPG_TTY (tty)
    gpg-connect-agent -q updatestartuptty /bye >/dev/null
end
