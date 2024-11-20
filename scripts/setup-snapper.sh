#!/usr/bin/env bash

set -euxo pipfail

# TODO: backup the whole HOME directory
# Setup auto backup
sudo btrfs subvolmue create "$HOME/dev"
sudo systemctl enable snapper-cleanup.timer snapper-timeline.timer
