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
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
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
      rust-overlay,
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
                # NOTE: pin the registry to GitHub so as to tell nix to reuse
                # the evaluated cache when use a unqualified `nixpkgs`
                type = "github";
                owner = "NixOS";
                repo = "nixpkgs";
                inherit (nixpkgs) rev lastModified narHash;
              };
              my.to = {
                type = "path";
                path = toString self;
              };
            };
            nixpkgs = {
              overlays = [
                rust-overlay.overlays.default
                (_: prev: { inherit myData; })
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
          ./programs/tmux-nightly.nix
          ./misc/extra-completions.nix
          ./misc/hm-session-vars.nix
          ./packages.nix
        ];
      };
      templates = import ./templates.nix;
    };
}
