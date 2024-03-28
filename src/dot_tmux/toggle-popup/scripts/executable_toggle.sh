#!/usr/bin/env bash

DEFAULT_FORMAT='popups/#{session_name}/#{@popup_name}'

declare name="default" cmd popup_args

while [[ $# -gt 0 ]]; do
  case $1 in
  --name)
    name="$2"
    shift
    shift
    ;;
  -[BCE])
    popup_args+=("$1")
    shift
    ;;
  -[bcdehsStTwxy])
    popup_args+=("$1" "$2")
    shift
    shift
    ;;
  -*)
    echo "Unknown argument '$1'" >&2
    exit 1
    ;;
  *)
    cmd="'$(printf "%q" "$@")'"
    break
    ;;
  esac
done

if [[ "$__tmux_toggle_popup" = "$name" ]]; then
  tmux detach
else
  format="$(tmux show -gqv @popup-format)"
  : "${format:=$DEFAULT_FORMAT}"

  popup_id="$(
    tmux \
      set @popup_name "$name" \; \
      display -p "$format" \; \
      set -u @popup_name
  )"
  tmux popup \
    "${popup_args[@]}" \
    "tmux new -e __tmux_toggle_popup='$name' -ADs '$popup_id' $cmd \; set status off"
fi
