if status is-login || status is-interactive
    # Use gpg-agent as default
    if test -d ~/.gnupg && type -q gpgconf
        set -e SSH_AGENT_PID
        if test -z $gnupg_SSH_AUTH_SOCK_BY; or test $gnupg_SSH_AUTH_SOCK_BY -ne $fish_pid
            set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
        end
    end
end

if status is-interactive
    # Use gpg-agent as default
    if test -d ~/.gnupg && type -q gpg-connect-agent
        set -gx GPG_TTY (tty)
        gpg-connect-agent updatestartuptty /bye >/dev/null
    end
end
