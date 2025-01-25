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

  # Install packages
  home.packages = with pkgs; [
    # Nix
    cachix
    nil
    nix-direnv
    nixfmt-rfc-style

    # Dotfiles manager
    chezmoi

    # Shell ulities
    atuin
    direnv
    starship
    #tmux
    zoxide

    # Git tools
    git
    git-cliff
    cz-cli
    lazygit
    husky

    # Dev tools
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

    # Misc tools
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
    cargo-flamegraph
    cargo-nextest
    cargo-show-asm
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

    # Configuration file linters
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
