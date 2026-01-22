#!/bin/sh
# TODO: sort with attached time
selected=$(tmux list-sessions -F '#{session_id} #{session_name}' | fzf \
	--accept-nth=1 --with-nth=2.. \
	--with-shell='/bin/sh -c' --preview="$HOME/.tmux/fzf_session_preview.sh {1}" "$@")
if [ -z "$selected" ]; then exit; fi
tmux switch-client -t "$selected"
