#!/usr/bin/env bash


# Nightfox colors for Tmux
# Upstream: github:edeneast/nightfox.nvim/main/extra/nightfox/nightfox_tmux.tmux
black="#131a24"
white="#aeafb0"
blue="#719cd6"
grey="#393b44"
seg_a="$blue $black"
seg_b="$grey $white"
seg_c="$black $white"

# Misc styles.
set -g mode-style "fg=$blue,bg=$white"
set -g message-style "fg=$blue,bg=$white"
set -g message-command-style "fg=$blue,bg=$white"
set -g status "on"
set -g status-justify "left"
set -g status-style "fg=$blue,bg=$black"

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
set -g @nova-pane-active-border-style "$blue"

# Mode segment.
set -g @nova-segment-mode "#[bold]#{?client_prefix,C-B,NOP}"
set -g @nova-segment-mode-colors "$seg_a"

# Whoami segment.
set -g @nova-segment-whoami "#[bold]#(whoami)@#h"
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
