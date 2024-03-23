{ pkgs, ... }:
let
  inherit (pkgs) myData;
in
{
  # Install packages.
  home.packages = with pkgs; [
    # Nix
    cachix
    nil
    nix-direnv

    # Dotfiles manager
    chezmoi

    # Shell
    direnv
    starship
    zoxide

    # Git
    git
    lazygit

    # CLI tools
    bat
    cocogitto
    degit
    delta
    du-dust
    eza
    fd
    fzf
    htop
    #hugo
    jq
    just
    kondo
    netcat
    p7zip
    patchelf
    ripgrep
    tealdeer
    tokei
    yazi

    # Misc
    caddy
    distrobox
    dufs
    gh
    jellyfin-ffmpeg
    sing-box
    wakatime

    #== Languages support ==#

    # Neovim
    neovim-nightly
    tree-sitter

    # Shell
    nodePackages.bash-language-server
    shellcheck
    shfmt

    # C/C++
    clang-tools
    cmake
    gnumake
    (stdenvAdapters.useMoldLinker stdenv).cc

    # Rust
    (with fenix.stable; fenix.combine [ defaultToolchain rust-src ])
    fenix-monthly.rust-analyzer

    # Cargo ulities
    cargo-edit
    #cargo-readme
    #cargo-release
    cargo-tarpaulin
    cargo-watch

    # Rust & WASM
    binaryen
    trunk
    wasm-bindgen-cli
    wasm-pack

    # Javascript/HTML/CSS
    #bun
    deno
    nodejs
    nodePackages.pnpm
    nodePackages.yarn

    prettierd
    nodePackages.eslint
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    tailwindcss-language-server

    # Python
    python
    poetry
    nodePackages.pyright

    # Lua
    lua
    stylua
    sumneko-lua-language-server

    ## Haskell
    #ghc
    #haskell-language-server

    # Golang
    go
    gopls
    delve

    # Etc
    perl
    hadolint
    taplo-cli
    nodePackages.yaml-language-server

    ## Document
    #texlive.combined.scheme-full
    #texlab
  ];
}
