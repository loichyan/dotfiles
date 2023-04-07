{ pkgs, ... }:
{
  # Let Home Manager manages itself.
  programs.home-manager.enable = true;

  # Install packages.
  home.packages = with pkgs;  [
    # Dotfiles manager
    chezmoi

    # Utils
    bat
    delta
    fd
    lsd
    netcat
    ripgrep
    sfz
    tmux
    tokei
    myPkgs.extra-files

    # Git
    commitizen
    git
    lazygit

    # Neovim
    neovim
    tree-sitter
    # used by LuaSnip
    luajitPackages.jsregexp

    # Shell
    direnv
    nix-direnv
    shellcheck
    shfmt
    starship
    zoxide

    # Dockerfile
    hadolint

    # C/C++
    clang-tools
    cmake
    gcc
    gnumake

    # Nix
    rnix-lsp

    # Node
    nodejs
    nodePackages.pnpm
    nodePackages.yarn
    # lsp/formatter/linter
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server

    # Prose linter & spell checker
    nodePackages.cspell
    vale

    # Deno
    deno

    # Python
    python3
    python3Packages.black
    python3Packages.virtualenv
    nodePackages.pyright

    # Rust
    rust-analyzer
    # cargo ulities
    cargo-edit
    cargo-readme
    cargo-release
    cargo-tarpaulin
    cargo-watch
    myPkgs.cargo-nightly-expand
    # wasm
    binaryen
    trunk
    wasm-bindgen-cli
    wasm-pack
    # toml
    taplo-cli

    # Lua
    stylua
    sumneko-lua-language-server

    # Perl
    perl
    # used by Yarn autocompleton
    perl536Packages.JSONPP
  ];
}
