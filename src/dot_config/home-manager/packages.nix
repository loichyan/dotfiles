{ pkgs, ... }:
{
  # Install packages.
  home.packages = with pkgs; [
    # Nix
    cachix
    nil
    nix-direnv
    nixfmt-rfc-style
    nixgl.auto.nixGLDefault

    # Dotfiles manager
    chezmoi

    # Shell
    atuin
    direnv
    starship
    tmux
    #zellij
    zoxide

    # Git
    git
    cz-cli
    degit
    lazygit

    # CLI tools
    ast-grep
    bat
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
    aria2
    caddy
    distrobox
    dufs
    gh
    jellyfin-ffmpeg
    wakatime

    #== Languages support ==#

    # Neovim
    neovim
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
    (
      with fenix.stable;
      fenix.combine [
        defaultToolchain
        rust-src
        rust-analyzer
      ]
    )
    sccache

    # Cargo ulities
    cargo-edit
    cargo-nextest
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
    nodePackages.prettier
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    tailwindcss-language-server

    # Python
    python
    basedpyright
    ruff-lsp

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
    gofumpt
    delve

    # Etc
    hadolint
    perl
    taplo-cli
    typos
    typos-lsp
    nodePackages.yaml-language-server

    ## Document
    #texlive.combined.scheme-full
    #texlab
  ];
}
