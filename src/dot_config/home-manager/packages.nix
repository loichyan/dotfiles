{ pkgs, ... }:
with builtins;
{
  programs.cargo-nightly-expand.enable = true;
  programs.home-manager.enable = true;
  misc.completions.enable = true;
  misc.hm-session-vars.enable = true;

  # Install packages.
  home.packages = with pkgs;  [
    # Dotfiles manager
    chezmoi

    # Utils
    cloudflared
    delta
    jq
    netcat
    safe-rm
    tmux
    tokei
    wakatime
    nodePackages.live-server

    # Coreutil replacements
    bat
    bottom
    broot
    du-dust
    exa
    fd
    htop
    ripgrep
    xcp

    # Git
    commitizen
    git
    lazygit

    # Neovim
    neovim
    tree-sitter
    # used by LuaSnip
    luajitPackages.jsregexp

    # Shell
    direnv
    nix-direnv
    shellcheck
    shfmt
    starship
    zoxide

    # Dockerfile
    hadolint

    # C/C++
    clang-tools
    cmake
    gnumake
    (stdenvAdapters.useMoldLinker stdenv).cc

    # Nix
    rnix-lsp

    # Node
    nodejs
    nodePackages.pnpm
    nodePackages.yarn
    # lsp/formatter/linter
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server

    # Prose linter & spell checker
    nodePackages.cspell
    vale

    # Deno
    deno

    # Python
    myPkgs.python3
    poetry
    nodePackages.pyright

    # Rust
    (with pkgs.fenix; with stable; combine [
      defaultToolchain
      rust-src
      rust-analyzer
    ])
    # cargo ulities
    cargo-edit
    cargo-readme
    cargo-release
    cargo-tarpaulin
    cargo-watch
    # wasm
    binaryen
    trunk
    wasm-bindgen-cli
    wasm-pack
    # toml
    taplo-cli

    # Lua
    stylua
    sumneko-lua-language-server

    # Java
    jdk8

    # Haskell
    ghc
    haskell-language-server

    # Golang
    go
    gopls

    # Dev Ops
    butane
    caddy
    hugo

    # Perl
    perl
    # used by Yarn autocompleton
    perl536Packages.JSONPP

    # Cue
    cue

    # Document
    texlive.combined.scheme-full
    texlab
  ];
}
