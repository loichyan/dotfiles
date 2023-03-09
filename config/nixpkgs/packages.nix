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
    fd
    netcat
    ripgrep
    sfz
    tmux
    tokei

    # Git
    commitizen
    git
    lazygit

    # Neovim
    neovim
    tree-sitter
    # used by LuaSnip
    (luajitPackages.jsregexp)

    # Shell
    direnv
    shfmt
    starship
    zoxide

    # C/C++
    gcc
    gnumake
    cmake
    clang-tools

    # Nix
    rnix-lsp

    # Node
    nodejs
    nodePackages.pnpm
    nodePackages.yarn
    # typescript
    (nodePackages.typescript-language-server)
    # prettier
    (nodePackages.prettier)
    # html/css/json/eslint
    (nodePackages.vscode-langservers-extracted)
    # prose linter
    vale

    # Deno
    deno

    # Python
    python3
    python3Packages.black
    python3Packages.virtualenv

    # Rust
    rust-analyzer
    # cargo ulities
    cargo-edit
    cargo-tarpaulin
    myPkgs.cargo-nightly-expand
    # wasm
    trunk
    wasm-bindgen-cli
    wasm-pack
    binaryen
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
