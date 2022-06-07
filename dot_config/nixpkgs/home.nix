{ config, pkgs, ... }:
{
  # Let Home Manager manages itself.
  programs.home-manager.enable = true;

  # Systemd services.
  systemd.user.services = {
    clash = {
      Unit = {
        Description = "A rule based proxy in Go.";
        After = "network.target";
      };
      Service = {
        Type = "exec";
        Restart = "on-abort";
        ExecStart = "${pkgs.clash}/bin/clash";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };

  # Packages
  home.packages = with pkgs;  [
    # Basic
    git
    gcc
    gnumake
    cmake
    neovim
    chezmoi

    # Utils
    ripgrep
    fd
    tokei
    bat
    nix-zsh-completions

    # Shell
    direnv
    zoxide
    shfmt

    # C/C++
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
    cargo
    rust-analyzer

    # Lua
    stylua
  ];
}
