#!/usr/bin/env bash

set -euxo pipfail

# Install Nix.
curl -L https://nixos.org/nix/install | sh -s -- --no-daemon

# Activate Home Manager
nix run home-manager/master -- switch
