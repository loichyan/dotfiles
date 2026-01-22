#!/bin/sh
active_pane=$(tmux list-panes -f '#{pane_active}' -F '#{pane_id}' -t "$1")
if [ -z "$active_pane" ]; then exit; fi
tmux capture-pane -ep -t "$active_pane"
