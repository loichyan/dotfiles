#!/usr/bin/bash

# Name:     Catppuccin Mocha
# Author:   Catppuccin Org
# License:  MIT
# Upstream: https://github.com/catppuccin/tmux

# shellcheck disable=SC2034
thm_bg="#24273a"
thm_fg="#cad3f5"
thm_cyan="#91d7e3"
thm_black="#1e2030"
thm_gray="#363a4f"
thm_magenta="#c6a0f6"
thm_pink="#f5bde6"
thm_red="#ed8796"
thm_green="#a6da95"
thm_yellow="#eed49f"
thm_blue="#8aadf4"
thm_orange="#f5a97f"
thm_black4="#5b6078"

black="$thm_black"
blue="$thm_blue"
gray="$thm_gray"
white="$thm_fg"
yellow="$thm_yellow"

seg_a="$blue $black"
seg_b="$gray $blue"

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
