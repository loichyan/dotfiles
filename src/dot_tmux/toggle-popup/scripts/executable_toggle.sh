#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/helpers.sh"

DEFAULT_FORMAT='popups/#{session_name}/#{@popup_name}'
DEFAULT_ON_OPEN='set status off'
DEFAULT_ON_CLOSE=''

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
    cmd="'$(printf '%q ' "$@")'"
    break
    ;;
  esac
done

if [[ "$__tmux_popup_name" = "$name" ]]; then
  on_close=$(showopt_hook @popup-on-close "$DEFAULT_ON_CLOSE")

  eval "tmux $on_close \; detach"
else
  format="$(showopt @popup-format "$DEFAULT_FORMAT")"
  on_open="$(showopt_hook @popup-on-open "$DEFAULT_ON_OPEN")"
  popup_id="$(tmux set @popup_name "$name" \; display -p "$format" \; set -u @popup_name)"

  tmux popup \
    "${popup_args[@]}" \
    "tmux new -e __tmux_popup_name='$name' -ADs '$popup_id' $cmd \; $on_open"
fi
