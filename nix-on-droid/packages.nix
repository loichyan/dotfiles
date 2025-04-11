{ pkgs }:
with pkgs;
[
  # General utilities
  chezmoi
  curl
  openssh
  p7zip
  rsync
  time
  tree
  wget
  zip

  # GnuPG
  gnupg
  pinentry-curses

  # Neovim
  neovim
  tree-sitter

  # Shell utilities
  direnv
  nix-direnv
  expect
  eza
  ncurses
  perl
  # TODO: back to the next stable release
  (callPackage ./tmux.nix { })
  zoxide

  # Git
  git
  lazygit

  # Dev utilities
  ast-grep
  bat
  delta
  fzf
  jq
  just
  ripgrep
  tokei

  # Js/Ts
  deno

  # C/C++
  stdenv.cc

  # Lua
  lua
  stylua
  sumneko-lua-language-server

  # Nix
  nil
  nixfmt-rfc-style
]
