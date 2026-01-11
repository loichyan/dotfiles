{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      home-manager,
      nix-index-database,
      rust-overlay,
    }@inputs:
    flake-utils.lib.eachDefaultSystemPassThrough (
      system:
      let
        myData = import ./data.nix;
        myRegistry = pkgs.callPackage ./packages/registry.nix {
          inherit inputs;
          lockfile = ./flake.lock;
        };
        myOverlay =
          _: super:
          let
            inherit (super) callPackage;
          in
          {
            inherit myData myRegistry;
            cargo-nightly-tools = callPackage ./packages/cargo-nightly-tools.nix { };
          };

        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            rust-overlay.overlays.default
            myOverlay
          ];
        };

        username = myData.user;
        homeDirectory = myData.home;
      in
      {
        packages.${system} = {
          inherit (pkgs)
            myRegistry
            cargo-nightly-tools
            ;
        };

        homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              home = {
                inherit username homeDirectory;
                stateVersion = "24.11";
                packages = [ myRegistry.flake-sync-lock ];
              };
              xdg.configFile."nix/registry.json".source = myRegistry.registry;
            }
            nix-index-database.homeModules.nix-index
            ./services/aria2.nix
            ./services/geodat.nix
            ./services/sing-box.nix
            ./services/tor.nix
            ./services/xray.nix
            ./misc/extra-completions.nix
            ./misc/hm-session-vars.nix
            ./packages.nix
          ];
        };
        templates = import ./templates.nix;
      }
    );
}
