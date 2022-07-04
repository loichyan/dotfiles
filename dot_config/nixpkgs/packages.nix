{ pkgs, ... }:
{
  # Let Home Manager manages itself.
  programs.home-manager.enable = true;

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
    myPkgs.cz-cli

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

    # Python
    (python3.withPackages
      (py: with py; [
        black
        jupyter
        virtualenv
      ])
    )

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
