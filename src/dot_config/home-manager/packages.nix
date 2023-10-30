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
    commitizen
    git
    lazygit

    # Neovim
    neovim
    tree-sitter

    # Dev tools
    bat
    cloudflared
    du-dust
    eza
    fd
    fzf
    htop
    jq
    just
    netcat
    p7zip
    ripgrep
    tokei

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
    go
    perl
    # LSP servers
    clang-tools
    delve
    gopls
    # FIXME: ilist is broken
    # hadolint
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

    # # Haskell
    # ghc
    # haskell-language-server
    # # Document
    # texlive.combined.scheme-full
    # texlab
  ];
}
