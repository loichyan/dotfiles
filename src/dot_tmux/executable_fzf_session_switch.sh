#!/bin/sh
SHELL=/bin/sh selected=$(
	tmux list-sessions -F \
		'#{?session_last_attached,#{session_last_attached},0} #{session_id} #{session_name}' |
		# Sort by access time, then session name.
		sort -k1,1nr -k3 |
		# Remove columns that should not be displayed.
		cut -d' ' -f2- |
		# Return the id of selected session.
		fzf --accept-nth=1 --with-nth=2.. --preview="$HOME/.tmux/fzf_session_preview.sh {1}" "$@"
)
if [ -z "$selected" ]; then exit; fi
tmux switch-client -t "$selected"
