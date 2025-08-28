{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # TODO: remove this input
    nixpkgs-dprint.url = "github:NixOS/nixpkgs/648f70160c03151bc2121d179291337ad6bc564b";
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
      nixpkgs-dprint,
      flake-utils,
      home-manager,
      nix-index-database,
      rust-overlay,
    }@inputs:
    let
      _ = flake-utils; # Currently only used to generate global registry
      myData = import ./data.nix;
      username = myData.user;
      homeDirectory = myData.home;
      system = "x86_64-linux";

      pkgs-dprint = nixpkgs-dprint.legacyPackages.${system};
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          rust-overlay.overlays.default
          (_: prev: {
            inherit myData;
            inherit (pkgs-dprint) dprint;
          })
        ];
      };

      registry = pkgs.callPackage ./packages/registry.nix {
        inherit inputs;
        lockfile = ./flake.lock;
      };
    in
    {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            home = {
              inherit username homeDirectory;
              stateVersion = "24.11";
              packages = [ registry.flake-sync-lock ];
            };
            xdg.configFile."nix/registry.json".source = registry.registry;
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
    };
}
