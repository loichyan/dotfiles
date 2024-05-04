{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix-monthly = {
      url = "github:nix-community/fenix/monthly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixgl,
      nix-index-database,
      fenix,
      fenix-monthly,
      neovim-nightly,
      ...
    }:
    let
      data = import ./data.nix;
      stateVersion = "23.11";
      username = data.user;
      homeDirectory = data.home;
      overlays = [
        nixgl.overlays.default
        neovim-nightly.overlays.default
        (_: prev: {
          myData = data;
          python = (
            prev.python3.withPackages (
              p: with p; [
                black
                ipython
                numpy
                pandas
                pip
              ]
            )
          );
          fenix = fenix.packages.${prev.system};
          fenix-monthly = fenix-monthly.packages.${prev.system};
        })
      ];
    in
    {
      homeConfigurations.${username} =
        let
          system = "x86_64-linux";
          pkgs = nixpkgs.legacyPackages.${system};
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              home = {
                inherit username homeDirectory stateVersion;
              };
              nix.registry = {
                nixpkgs.to = {
                  type = "path";
                  path = "${nixpkgs}";
                };
                my.to = {
                  type = "path";
                  path = "${self}";
                };
              };
              nixpkgs = {
                inherit overlays;
              };
              programs.home-manager.enable = true;
            }
            nix-index-database.hmModules.nix-index
            #./programs/arrow-tools.nix
            ./programs/cargo-nightly-tools.nix
            #./programs/zellij-nightly.nix
            ./services/aria.nix
            ./services/sing-box.nix
            ./services/tor.nix
            ./misc/extra-completions.nix
            ./misc/hm-session-vars.nix
            ./packages.nix
          ];
        };
      templates = {
        basic = {
          path = ./templates/basic;
          description = "Nix project starter";
        };
        justfile = {
          path = ./templates/justfile;
          description = "Justfile starter";
        };
        python = {
          path = ./templates/python;
          description = "Python project starter";
        };
        repo = {
          path = ./templates/repo;
          description = "Repository starter with MIT OR Apache-2.0 license";
        };
        repo-gpl = {
          path = ./templates/repo-gpl;
          description = "Repository starter with GPL-3.0 license";
        };
        rust = {
          path = ./templates/rust;
          description = "Rust library starter";
        };
        rust-bin = {
          path = ./templates/rust-bin;
          description = "Rust binary starter";
        };
      };
    };
}
