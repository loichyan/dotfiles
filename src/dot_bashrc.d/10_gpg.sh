# c.f. https://wiki.archlinux.org/title/GnuPG#SSH_agent
unset SSH_AGENT_PID
if [[ $gnupg_SSH_AUTH_SOCK_BY != "$$" ]]; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

export GPG_TTY="$(tty)"
gpg-connect-agent --quiet updatestartuptty /bye >/dev/null
