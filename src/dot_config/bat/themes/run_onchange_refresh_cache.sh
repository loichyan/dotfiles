#!/usr/bin/env bash

# Update bat cache
if command -v bat &>/dev/null; then
	bat cache --build
fi
