if status is-login || status is-interactive
    if test -d ~/.gnupg && type -q gpgconf && type -q gpg-connect-agent
        # https://wiki.archlinux.org/title/GnuPG#SSH_agent
        set -e SSH_AGENT_PID
        if test -z $gnupg_SSH_AUTH_SOCK_BY || test $gnupg_SSH_AUTH_SOCK_BY -ne $fish_pid
            set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
        end

        if status is-interactive
            # Configure pinentry to use the correct TTY
            set -gx GPG_TTY (tty)
            gpg-connect-agent --quiet updatestartuptty /bye >/dev/null
        end
    end
end
