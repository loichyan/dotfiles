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
    fzf
    starship
    zoxide
    #tmux

    # Git tools
    git
    git-cliff
    cz-cli
    lazygit
    husky
    delta

    # Dev tools
    ast-grep
    bottom
    distrobox
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
    jellyfin-ffmpeg
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
    sccache
    taplo-cli

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

    # Other formaters & linters
    dprint
    hadolint
    typos
    typos-lsp
    nodePackages.yaml-language-server

    ## Document
    #texlive.combined.scheme-full
    #texlab
  ];

  xdg.configFile."dprint/plugins.json".text = with pkgs.dprint-plugins; ''
    {
      "plugins": [
        "${dprint-plugin-biome}/plugin.wasm",
        "${dprint-plugin-dockerfile}/plugin.wasm"
        "${dprint-plugin-json}/plugin.wasm",
        "${dprint-plugin-markdown}/plugin.wasm",
        "${g-plane-malva}/plugin.wasm",
        "${g-plane-markup_fmt}/plugin.wasm",
        "${g-plane-pretty_graphql}/plugin.wasm",
        "${g-plane-pretty_yaml}/plugin.wasm"
      ]
    }
  '';
}
