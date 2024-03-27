#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

bind_popup() {
	local key="$1"
	local name="$2"
	local size="$3"
	local run="$4"

	tmux bind -n "$key" run "$CURRENT_DIR/scripts/toggle.sh '$name' '$run' -E -w $size -h $size"
}

bind_popup M-t scratch 75%
bind_popup M-e yazi 90% yazi
bind_popup M-g lazygit 90% lazygit
