{ pkgs, ... }:
{
  # install packages
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    # nix
    cachix
    nil
    nix-direnv
    nixfmt-rfc-style
    nixgl.auto.nixGLDefault

    # dotfiles manager
    chezmoi

    # shell ulities
    atuin
    direnv
    starship
    tmux
    #zellij
    zoxide

    # git tools
    git
    git-cliff
    cz-cli
    lazygit

    # dev tools
    ast-grep
    bat
    bottom
    delta
    distrobox
    du-dust
    eza
    fd
    fzf
    jq
    just
    kondo
    patchelf
    ripgrep
    tokei

    # misc apps
    aria2
    dufs
    gh
    jellyfin-ffmpeg
    netcat
    p7zip
    wakatime
    yazi

    #== Languages support ==#

    # Neovim
    neovim
    tree-sitter

    # Shell
    perl
    shellcheck
    shfmt
    nodePackages.bash-language-server

    # C/C++
    clang-tools
    cmake
    gnumake

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

    # Javascript/HTML/CSS
    deno
    nodejs
    nodePackages.pnpm
    nodePackages.yarn

    prettierd
    tailwindcss-language-server
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted

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
    taplo-cli
    typos
    typos-lsp
    nodePackages.yaml-language-server

    ## Document
    #texlive.combined.scheme-full
    #texlab
  ];
}
