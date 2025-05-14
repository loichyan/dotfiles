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
    }:
    let
      _ = flake-utils; # Currently only used to generate global registry
      myData = import ./data.nix;
      username = myData.user;
      homeDirectory = myData.home;

      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (pkgs) lib;

      lockfile = lib.importJSON ./flake.lock;
      getLocked = name: lockfile.nodes.${name}.locked;
    in
    {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            home = {
              inherit username homeDirectory;
              stateVersion = "24.11";
            };
            nix.registry = {
              # NOTE: pin the registry to GitHub so as to tell nix to reuse
              # the evaluated cache when use a unqualified `nixpkgs`
              nixpkgs.to = getLocked "nixpkgs";
              flake-utils.to = getLocked "flake-utils";
              rust-overlay.to = getLocked "rust-overlay";
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
