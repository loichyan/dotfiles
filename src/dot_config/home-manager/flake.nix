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
    let
      _ = flake-utils; # Currently only used to generate global registry
      myData = import ./data.nix;
      username = myData.user;
      homeDirectory = myData.home;

      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
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
            nixpkgs = {
              overlays = [
                rust-overlay.overlays.default
                (_: prev: { inherit myData; })
              ];
            };
            xdg.configFile."nix/registry.json".source = registry.registry;
          }
          nix-index-database.hmModules.nix-index
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
