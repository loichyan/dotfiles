{ pkgs, ... }:
{
  programs.home-manager.enable = true;
  programs.nix-index.enable = true;

  # Install packages
  home.packages = with pkgs; [
    # Nix
    cachix
    nil
    nixfmt-rfc-style

    # Dotfiles manager
    chezmoi

    # Neovim
    neovim
    tree-sitter
    wakatime

    # Shell ulities
    atuin
    bat
    direnv
    nix-direnv
    du-dust
    expect
    eza
    fd
    starship
    zoxide
    (callPackage ./packages/fzf.nix { })
    # TODO: back to the next stable release
    (callPackage ./packages/tmux-nightly.nix { })

    # Git tools
    git
    git-cliff
    cz-cli
    lazygit
    delta

    # Dev tools
    ast-grep
    bottom
    distrobox
    hyperfine
    jq
    just
    kondo
    patchelf
    ripgrep
    tokei

    # Misc tools
    aria2
    docker-compose
    gh
    ffmpeg
    netcat
    p7zip
    static-web-server

    # Fonts used by terminal
    (callPackage ./packages/ZxProtoNF.nix { })

    #== Languages support ==#

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
    (rust-bin.stable.latest.default.override {
      extensions = [
        "rust-src"
        "rust-analyzer"
      ];
    })
    (callPackage ./packages/cargo-nightly-tools.nix { })
    mold

    # Cargo ulities
    cargo-flamegraph
    cargo-nextest
    cargo-show-asm
    cargo-watch

    # Web
    deno
    nodejs
    nodePackages.pnpm

    tailwindcss-language-server
    nodePackages.eslint
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted

    # Python
    python3
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

    # Other formaters & linters
    dprint
    hadolint
    nodePackages.yaml-language-server
    taplo-cli
    typos
    typos-lsp
    vale

    ## Document
    #texlive.combined.scheme-full
    #texlab
  ];
}
