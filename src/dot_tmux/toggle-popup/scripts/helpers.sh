#!/usr/bin/env bash

showopt() {
  local v="$(tmux show-option -gqv "$1")"
  echo "${v:-"$2"}"
}

showopt_hook() {
  showopt "$@" | xargs printf '%q '
}

bindkey() {
  tmux bind-key "$@"
}
