#!/usr/bin/env bash

rpm-ostree upgrade &
flatpak update &

{
  env -C ~/.config/home-manager nix flake update
  home-manager switch --impure
} &

nvim --headless +'Lazy update' +q &
