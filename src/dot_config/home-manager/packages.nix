{ pkgs, ... }:
{
  programs.home-manager.enable = true;
  programs.nix-index.enable = true;

  # Install packages
  home.packages = with pkgs; [
    # Nix
    cachix
    nil
    nixfmt

    # Dotfiles manager
    chezmoi

    # Neovim
    neovim
    tree-sitter
    wakatime-cli

    # Shell ulities
    atuin
    bat
    direnv
    dust
    expect
    eza
    fd
    fish
    fzf
    nix-direnv
    starship
    tmux
    zoxide

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
    husky
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
    netcat
    p7zip
    static-web-server

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
    cargo-nightly-tools
    mold
    sccache

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
    uv

    # Lua
    lua
    stylua
    lua-language-server

    ## Haskell
    #ghc
    #haskell-language-server

    # Golang
    go
    gopls
    gofumpt
    delve

    # Other formaters & linters
    hadolint
    nodePackages.yaml-language-server
    taplo
    typos
    typos-lsp
    vale

    ## Document
    #texlive.combined.scheme-full
    #texlab
  ];
}
