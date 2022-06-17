#!/usr/bin/env bash

# Onedark theme (odedlaz/tmux-onedark-theme).
black="#282c34"
white="#aab2bf"
green="#98c379"
grey="#3e4452"
seg_a="$green black"
seg_b="$grey $white"
seg_c="$black $white"

# Single row.
set -g @nova-rows 0

# Enable nerdfonts.
set -g @nova-nerdfonts true

# Status bar style.
set -g @nova-status-style-bg "$black"
set -g @nova-status-style-fg "$white"
set -g @nova-status-style-double-bg "$black"

# Pane style.
set -g @nova-pane "#S:#W"
set -g @nova-status-style-active-bg "$black"
set -g @nova-status-style-active-fg "$white"
set -g @nova-pane-border-style "$black"
set -g @nova-pane-active-border-style "$green"

# Mode segment.
set -g @nova-segment-mode "#{?client_prefix,C-B,NOP}"
set -g @nova-segment-mode-colors "$seg_a"

# Whoami segment.
set -g @nova-segment-whoami-colors "$seg_a"

# Date segment.
set -g @nova-segment-date "%Y/%m/%d"
set -g @nova-segment-date-colors "$seg_b"

# Time segment.
set -g @nova-segment-time "%R"
set -g @nova-segment-time-colors "$seg_c"

# Left segments.
set -g @nova-nerdfonts-left ""
set -g @nova-segments-0-left "mode"

# Right segments.
set -g @nova-nerdfonts-right ""
set -g @nova-segments-0-right "time date whoami"
