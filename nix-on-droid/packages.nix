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
  wakatime

  # Shell utilities
  atuin
  bat
  direnv
  nix-direnv
  du-dust
  expect
  eza
  fd
  fzf
  zoxide
  # TODO: back to the next stable release
  (callPackage ./tmux.nix { })

  # Git
  git
  lazygit
  delta

  # Dev utilities
  ast-grep
  bat
  delta
  jq
  just
  ripgrep
  tokei

  #== Languages support ==#

  # Shell
  perl
  shellcheck
  shfmt
  nodePackages.bash-language-server

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

  # Other linters
  typos
  typos-lsp
]
