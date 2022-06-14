{ pkgs, ... }:
{
  # Install packages.
  home.packages = with pkgs;  [
    # Basic
    git
    neovim
    chezmoi

    # Utils
    ripgrep
    fd
    tokei
    bat
    tmux

    # Shell
    direnv
    zoxide
    shfmt

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

    # Python
    python310
    python310Packages.pip

    # Rust
    rust-bin.stable.latest.default
    rust-analyzer

    # Lua
    stylua
  ];
}
