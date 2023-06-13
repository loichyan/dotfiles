if status is-login
    # Use gpg-agent as default
    if [ -d ~/.gnupg ] && type -q gpgconf && type -q gpg-connect-agent
        export GPG_TTY=(tty)
        export SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)
        echo UPDATESTARTUPTTY | gpg-connect-agent 1> /dev/null
    end
end
