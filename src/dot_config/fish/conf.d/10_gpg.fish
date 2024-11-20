if status is-login || status is-interactive
    if test -d ~/.gnupg && type -q gpgconf && type -q gpg-connect-agent
        # c.f. https://wiki.archlinux.org/title/GnuPG#SSH_agent
        set -e SSH_AGENT_PID
        if test "$gnupg_SSH_AUTH_SOCK_BY" != $fish_pid
            set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
        end

        # Cnfigure pinentry to use the correct TTY
        set -gx GPG_TTY (tty)
        gpg-connect-agent --quiet updatestartuptty /bye >/dev/null
    end
end
