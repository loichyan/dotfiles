#!/usr/bin/env bash

name="$1"
run="$2"
extra_args=("${@:3}")

if [[ "$__tmux_toggle_popup" = "$name" ]]; then
  tmux detach
else
  session_id="$(tmux display -p "#{session_id}")"
  session_name="$(tmux display -p "#S")"
  popup_id="__${session_name}/${session_id:1}/$name"
  tmux popup \
    "${extra_args[@]}" \
    "tmux new -e __tmux_toggle_popup='$name' -ADs '$popup_id' $run \; set status off"
fi
