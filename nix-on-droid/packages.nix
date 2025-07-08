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
  jq
  just
  ripgrep
  tokei

  # Misc tools
  static-web-server

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
  sccache
  taplo-cli

  # Web
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

  # Python
  python3

  # Other formaters & linters
  dprint
  typos
  typos-lsp
  vale
]
