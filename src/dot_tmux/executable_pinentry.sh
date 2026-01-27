#!/usr/bin/env bash

# Credit to
# - https://github.com/eth-p/pinentry-tmux
# - https://github.com/qualIP/pinentry-tmux

# Do nothing but wait pinentry to attach.
start_remote() {
	trap 'kill -INT "$CALLER" 2>/dev/null' INT
	printf '%d %s %s' "$$" "$TERM" "$(tty)" >"$CONFIG/remote"
	sleep infinity
}

# Display popup and start pinentry.
start_local() {
	CALLER=$$
	CONFIG=$(mktemp -u)
	mkdir -m 700 "$CONFIG"
	trap 'abort' INT
	trap 'cleanup' EXIT

	mkfifo "$CONFIG/stdin" "$CONFIG/stdout"
	pinentry-curses <"$CONFIG/stdin" >"$CONFIG/stdout" &
	subproc+=("$!")

	# Process and intercept input instructions.
	exec 3>"$CONFIG/stdin" 4<"$CONFIG/stdout" # open connection
	recv                                      # receive greeting message
	while IFS= read -r line; do

		case "$line" in
		# ignore tty setting
		'OPTION ttyname='*) echo OK ;;
		'OPTION ttytype='*) echo OK ;;

		# get $TMUX from the owner
		'OPTION owner='*)
			[[ ${line:7} =~ ^owner=([[:digit:]]+) ]]
			owner_pid=${BASH_REMATCH[1]}
			owner_tmux=$(getenv "$owner_pid" TMUX)

			mkfifo "$CONFIG/remote"
			TMUX=$owner_tmux tmux display-popup -E \
				-w100% -h100% -B \
				-e PINENTRY_TMUX_CALLER="$CALLER" \
				-e PINENTRY_TMUX_CONFIG="$CONFIG" \
				"$0" &

			IFS=' ' read -r remote_pid remote_term remote_tty <"$CONFIG/remote" || :

			subproc+=("$remote_pid")
			send "OPTION ttyname=$remote_tty" >/dev/null  # discard response as already handled
			send "OPTION ttytype=$remote_term" >/dev/null # discard response as already handled

			send "$line"
			;;

		# forward other instructions
		*) send "$line" ;;
		esac
	done

	exec 3>&- 4<&- # close connection
	tmux popup -C  # close popup
}

# Send instructions to pinentry and wait for response.
send() {
	printf "%s\n" "$@" >&3
	recv
}

# Receive response from pinentry.
recv() {
	while IFS=' ' read -r cmd val; do
		printf "%s %s\n" "$cmd" "$val"
		if [[ $cmd == OK || $cmd == ERR ]]; then break; fi
	done <&4
}

# Fetch environment from the given process.
getenv() {
	local pid=$1 target=$2
	while IFS='=' read -rd '' key val; do
		if [[ $key == "$target" ]]; then
			printf '%s' "$val"
			return
		fi
	done <"/proc/$pid/environ"
	return 1
}

# Abort due to interruption.
abort() {
	echo "ERR 83886179 Operation cancelled <Pinentry>"
	exit 1
}

# Stop subprocesses and remove temporary files.
subproc=()
cleanup() {
	kill "${subproc[@]}" 2>/dev/null
	if [[ -e "$CONFIG/stdin" ]]; then rm "$CONFIG/stdin"; fi
	if [[ -e "$CONFIG/stdout" ]]; then rm "$CONFIG/stdout"; fi
	if [[ -e "$CONFIG/remote" ]]; then rm "$CONFIG/remote"; fi
	if [[ -e "$CONFIG" ]]; then rmdir "$CONFIG"; fi
	echo BYE
}

set -eo pipefail
CALLER=$PINENTRY_TMUX_CALLER
CONFIG=$PINENTRY_TMUX_CONFIG
if [[ -z $CALLER ]]; then start_local; else start_remote; fi
