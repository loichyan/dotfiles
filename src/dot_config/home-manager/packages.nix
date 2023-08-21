{ pkgs, ... }:
with builtins;
let
  inherit (pkgs) myData;
in
{
  programs.home-manager.enable = true;
  services.aria.enable = true;
  services.tor.enable = true;
  services.xray.enable = myData.proxyEnabled;
  misc.completions.enable = true;
  misc.hm-session-vars.enable = true;
  # programs.cargo-nightly-expand.enable = true;

  # Install packages.
  home.packages = with pkgs;  [
    # Dotfiles manager
    chezmoi

    # Shell
    direnv
    nix-direnv
    shellcheck
    shfmt
    starship
    zoxide

    # Git
    commitizen
    git
    lazygit

    # Neovim
    neovim
    tree-sitter

    # Dev tools
    bat
    cloudflared
    erdtree
    exa
    fd
    htop
    jq
    netcat
    ripgrep
    tokei

    # Misc
    wakatime
    caddy
    nodePackages.live-server

    #== Languages support ==#

    # C/C++
    cmake
    gnumake
    (stdenv.cc.override {
      bintools = llvmPackages.bintools;
    })

    # Rust
    (with pkgs.fenix; with stable; combine [
      defaultToolchain
      rust-analyzer
      rust-src
    ])

    # Cargo ulities
    cargo-edit
    cargo-readme
    cargo-release
    cargo-tarpaulin
    cargo-watch

    # Rust & WASM
    binaryen
    trunk
    wasm-bindgen-cli
    wasm-pack

    # JavaScript
    deno
    nodejs
    nodePackages.pnpm
    nodePackages.yarn

    # Python
    poetry
    python
    nodePackages.pyright

    # Others
    ghc
    go
    perl

    # LSP servers
    clang-tools
    delve
    gopls
    hadolint
    haskell-language-server
    rnix-lsp
    sumneko-lua-language-server

    # Formatter/linter
    prettierd
    stylua
    taplo-cli
    nodePackages.eslint
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server

    # Document
    #texlive.combined.scheme-full
    #texlab
  ];
}
