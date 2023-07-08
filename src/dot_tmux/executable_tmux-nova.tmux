#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

set_opt() {
	local option="$1"
	local value="$2"
	tmux set-option -gq "$option" "$value"
}

# Load colors
source "${CURRENT_DIR}/colorscheme.sh"

seg_a="$blue $black"
seg_b="$gray $blue"

# Misc styles.
set_opt mode-style "fg=$black,bg=$yellow"
set_opt message-style "fg=$black,bg=$yellow"
set_opt message-command-style "fg=$black,bg=$yellow"

# Single row.
set_opt @nova-rows 0

# Enable nerdfonts.
set_opt @nova-nerdfonts true

# Status bar style.
set_opt @nova-status-style-bg "$black"
set_opt @nova-status-style-fg "$white"
set_opt @nova-status-style-double-bg "$black"

# Pane style.
set_opt @nova-pane "#{}"
set_opt @nova-status-style-active-bg "$black"
set_opt @nova-status-style-active-fg "$white"
set_opt @nova-pane-border-style "$black"
set_opt @nova-pane-active-border-style "$blue"
set_opt @nova-pane-justify "left"

# Mode segment.
set_opt @nova-segment-mode "#[bold]#{?client_prefix,PREFIX,NORMAL}#[nobold]"
set_opt @nova-segment-mode-colors "$seg_a"

# Pane segment.
set_opt @nova-segment-pane "#S:#W"
set_opt @nova-segment-pane-colors "$seg_b"

# Whoami segment.
set_opt @nova-segment-whoami "#[bold]#(whoami)@#h#[nobold]"
set_opt @nova-segment-whoami-colors "$seg_a"

# Date segment.
set_opt @nova-segment-date "%Y/%m/%d"
set_opt @nova-segment-date-colors "$seg_b"

# Left segments.
set_opt status-left-length 60
set_opt @nova-nerdfonts-left ""
set_opt @nova-segments-0-left "mode pane"

# Right segments.
set_opt @nova-nerdfonts-right ""
set_opt @nova-segments-0-right "date whoami"
