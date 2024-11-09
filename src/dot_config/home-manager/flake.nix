{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix-monthly = {
      url = "github:nix-community/fenix/monthly";
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
      ...
    }:
    let
      myData = import ./data.nix;
      username = myData.user;
      homeDirectory = myData.home;
      system = "x86_64-linux";
    in
    {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          {
            home = {
              inherit username homeDirectory;
              stateVersion = "24.11";
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
              overlays = [
                (_: prev: {
                  inherit myData;
                  fenix = fenix.packages.${prev.system};
                  fenix-monthly = fenix-monthly.packages.${prev.system};
                })
              ];
            };
            nixGL.packages = nixgl.packages;
          }
          nix-index-database.hmModules.nix-index
          ./services/aria2.nix
          ./services/geodat.nix
          ./services/sing-box.nix
          ./services/tor.nix
          ./services/xray.nix
          ./programs/cargo-nightly-tools.nix
          ./misc/extra-completions.nix
          ./misc/hm-session-vars.nix
          ./packages.nix
        ];
      };
      templates = import ./templates.nix;
    };
}
