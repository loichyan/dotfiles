#!/usr/bin/env bash

has() {
	# shellcheck disable=SC2046
	return $(command -v "$1" &>/dev/null)
}

# Update bat cache
if has bat; then
	bat cache --build
fi
