#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

bind_popup() {
	local key="$1"
	local size="$2"
	local args=("${@:3}")

	tmux bind -n "$key" run \
		"$CURRENT_DIR/scripts/toggle.sh -E -d '#{pane_current_path}' -w $size -h $size ${args[*]}"
}

bind_popup M-t 75% --name scratch
bind_popup M-e 90% --name yazi yazi
bind_popup M-g 90% --name lazygit lazygit
