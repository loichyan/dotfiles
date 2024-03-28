#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

showopt() {
	tmux show -gqv "$1"
}

for name in $(showopt @popup-bind | tr "," $"\n"); do
	cmd="$(showopt "@popup-bind-$name")"
	table="$(showopt "@popup-bind-$name-T")"
	key="$(showopt "@popup-bind-$name-key")"

	tmux bind \
		-T "$table" "$key" \
		run "$CURRENT_DIR/scripts/toggle.sh --name '$name' $cmd"
done
