{ pkgs, ... }:
{
  # Let Home Manager manages itself.
  programs.home-manager.enable = true;

  # Install packages.
  home.packages = with pkgs;  [
    # Basic
    git
    chezmoi

    # Utils
    ripgrep
    fd
    tokei
    bat
    tmux
    myPkgs.cz-cli
    netcat
    lazygit

    # Neovim
    neovim
    xclip
    wl-clipboard
    nixgl-wrapped.neovide

    # Shell
    direnv
    zoxide
    shfmt
    starship

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

    # Typescript
    (nodePackages.typescript-language-server)

    # Deno
    deno

    # Python
    python3
    python3Packages.black
    python3Packages.virtualenv

    # Rust
    rust-analyzer
    cargo-edit
    cargo-tarpaulin
    trunk
    wasm-bindgen-cli
    wasm-pack
    binaryen
    myPkgs.cargo-nightly-expand

    # Lua
    stylua
    sumneko-lua-language-server

    # Web
    myPkgs.prettierd

    # Perl
    perl
    perl536Packages.JSONPP

    # Others
    (nodePackages.code-json-languageserver)
    taplo-cli
    vale
    sfz
  ];
}