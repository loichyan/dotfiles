{ pkgs, ... }:
{
  programs.home-manager.enable = true;
  programs.nix-index.enable = true;

  nixGL.defaultWrapper = "mesa";
  nixGL.offloadWrapper = "nvidia";
  nixGL.installScripts = [
    "mesa"
    "nvidia"
  ];

  # install packages
  home.packages = with pkgs; [
    # nix
    cachix
    nil
    nix-direnv
    nixfmt-rfc-style

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

    # misc tools
    aria2
    docker-compose
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
    cargo-flamegraph
    cargo-nextest
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
    (python3.withPackages (
      p: with p; [
        ipython
        pip
      ]
    ))
    basedpyright
    ruff

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
