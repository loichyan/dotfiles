#!/usr/bin/env bash

set -euxo pipfail

# Auto backup
sudo btrfs subvolmue create "$HOME/dev"
sudo systemctl enable snapper-cleanup.timer snapper-timeline.timer
