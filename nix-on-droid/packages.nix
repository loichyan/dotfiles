{ pkgs }:
with pkgs;
[
  # General utilities
  chezmoi
  curl
  openssh
  rsync
  wget
  zip

  # GnuPG
  gnupg
  pinentry-curses

  # Neovim
  neovim
  tree-sitter
  wakatime-cli

  # Shell utilities
  atuin
  bat
  direnv
  dust
  expect
  eza
  fd
  nix-direnv
  tmux
  zoxide

  # Git
  git
  lazygit
  delta

  # Dev utilities
  ast-grep
  bat
  husky
  hyperfine
  jq
  just
  ripgrep
  tokei

  # Misc tools
  static-web-server
  optipng

  #== Languages support ==#

  # Shell
  perl
  shellcheck
  shfmt
  nodePackages.bash-language-server

  # Rust
  (rust-bin.stable.latest.default.override {
    extensions = [
      "rust-src"
      "rust-analyzer"
    ];
  })
  mold

  # Web
  deno
  nodePackages.typescript-language-server

  # C/C++
  stdenv.cc
  cmake
  gnumake

  # Lua
  lua
  stylua
  lua-language-server

  # Nix
  nil
  nixfmt-rfc-style

  # Python
  python3
  basedpyright
  ruff

  # Other formaters & linters
  taplo
  typos
  typos-lsp
  vale
]
