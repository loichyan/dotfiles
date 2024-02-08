{ pkgs, ... }:
let
  inherit (pkgs) myData;
in
{
  # Install packages.
  home.packages = with pkgs; [
    cachix

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
    git
    lazygit

    # Neovim
    neovim-nightly
    tree-sitter

    # Tools
    bat
    cloudflared
    delta
    du-dust
    eza
    fd
    fzf
    gh
    htop
    hugo
    jq
    just
    kondo
    netcat
    p7zip
    patchelf
    ripgrep
    tokei
    yazi

    # Misc
    wakatime
    caddy
    dufs
    xray

    #== Languages support ==#

    # C/C++
    cmake
    gnumake
    (stdenvAdapters.useMoldLinker stdenv).cc

    # Rust
    (with fenix.stable; fenix.combine [ defaultToolchain rust-src ])
    fenix-monthly.rust-analyzer

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
    go
    perl
    # LSP servers
    clang-tools
    delve
    gopls
    hadolint
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

    # Lua
    lua

    # # Haskell
    # ghc
    # haskell-language-server
    # # Document
    # texlive.combined.scheme-full
    # texlab
  ];
}
