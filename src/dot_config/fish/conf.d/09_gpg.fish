if status is-login
   # Use gpg-agent as default
   if test -d ~/.gnupg && type -q gpg && type -q gpg-agent
      export SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)
      echo UPDATESTARTUPTTY | gpg-connect-agent 1> /dev/null
   end
end
