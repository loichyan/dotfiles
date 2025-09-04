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
  zoxide
  # TODO: back to the next stable release
  tmux-nightly

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

  # Fonts used by terminals
  ZxProtoNF

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
  mold-wrapped

  # Web
  deno

  # C/C++
  stdenv.cc
  cmake
  gnumake

  # Lua
  lua
  stylua
  sumneko-lua-language-server

  # Nix
  nil
  nixfmt-rfc-style

  # Python
  python3
  basedpyright
  ruff

  # Other formaters & linters
  dprint
  taplo-cli
  typos
  typos-lsp
  vale
]
