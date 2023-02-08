#!/usr/bin/bash

# Name: Tokyo Night Moon
# License: MIT
# Author: Folke Lemaitre
# Upstream: https://github.com/folke/tokyonight.nvim/raw/main/extras/tmux/tokyonight_moon.conf
black="#1e2030"
white="#828bb8"
blue="#82aaff"
yellow="#ffc777"
grey="#3b4261"
seg_a="$blue $black"
seg_b="$grey $blue"

# Misc styles.
set -g mode-style "fg=$black,bg=$yellow"
set -g message-style "fg=$black,bg=$yellow"
set -g message-command-style "fg=$black,bg=$yellow"

# Single row.
set -g @nova-rows 0

# Enable nerdfonts.
set -g @nova-nerdfonts true

# Status bar style.
set -g @nova-status-style-bg "$black"
set -g @nova-status-style-fg "$white"
set -g @nova-status-style-double-bg "$black"

# Pane style.
set -g @nova-pane "#{}"
set -g @nova-status-style-active-bg "$black"
set -g @nova-status-style-active-fg "$white"
set -g @nova-pane-border-style "$black"
set -g @nova-pane-active-border-style "$blue"
set -g @nova-pane-justify "left"

# Mode segment.
set -g @nova-segment-mode "#[bold]#{?client_prefix,PREFIX,NORMAL}#[nobold]"
set -g @nova-segment-mode-colors "$seg_a"

# Pane segment.
set -g @nova-segment-pane "#S:#W"
set -g @nova-segment-pane-colors "$seg_b"

# Whoami segment.
set -g @nova-segment-whoami "#[bold]#(whoami)@#h#[nobold]"
set -g @nova-segment-whoami-colors "$seg_a"

# Date segment.
set -g @nova-segment-date "%Y/%m/%d"
set -g @nova-segment-date-colors "$seg_b"

# Left segments.
set -g status-left-length 60
set -g @nova-nerdfonts-left ""
set -g @nova-segments-0-left "mode pane"

# Right segments.
set -g @nova-nerdfonts-right ""
set -g @nova-segments-0-right "date whoami"
