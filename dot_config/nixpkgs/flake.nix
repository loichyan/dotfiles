{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    myPkgs = {
      url = "./pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };
  };

  outputs = { nixpkgs, home-manager, rust-overlay, myPkgs, ... }:
    let
      data = import ./data.nix;
      username = data.user;
      homeDirectory = data.home;
      stateVersion = "22.11";
      overlays = [
        rust-overlay.overlays.default
        myPkgs.overlays.default
      ];
    in
    {
      homeConfigurations."${username}" =
        let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system overlays;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            { home = { inherit username homeDirectory stateVersion; }; }
            ./packages.nix
            ./services.nix
          ];
        };
      templates = {
        basic = {
          path = ./templates/basic;
          description = "A simple nix project.";
        };
        license = {
          path = ./templates/license;
          description = "MIT OR Apache-2.0 license.";
        };
        rust = {
          path = ./templates/rust;
          description = "A simple rust project.";
        };
      };
    };
}
