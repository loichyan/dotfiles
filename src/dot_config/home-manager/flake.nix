{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, fenix, ... }:
    let
      data = import ./data.nix;
      stateVersion = "23.05";
      username = data.user;
      homeDirectory = data.home;
      overlays = [
        fenix.overlays.default
        (_: prev: {
          myData = data;
          myPkgs = prev.callPackage ./pkgs/default.nix { };
        })
      ];
    in
    {
      homeConfigurations.${username} =
        let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system overlays;
            config.allowUnfree = true;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              home = { inherit username homeDirectory stateVersion; };
              programs.home-manager.enable = true;
            }
            ./packages.nix
            ./services.nix
          ];
        };
    };
}
