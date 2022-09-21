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

    # Neovim
    neovim
    xclip
    wl-clipboard

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

    # Deno
    deno

    # Python
    python3Packages.black

    # Rust
    (rust-bin.stable.latest.default.override {
      extensions = [ "rust-src" ];
    })
    rust-analyzer

    # Lua
    stylua
    sumneko-lua-language-server

    # Web
    myPkgs.prettierd

    # Others
    taplo-cli
  ];
}
