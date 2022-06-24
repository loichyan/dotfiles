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
    };
  };

  outputs = { nixpkgs, home-manager, rust-overlay, myPkgs, ... }:
    let
      username = data.user;
      data = import ./data.nix;
      homeDirectory = data.home;
      stateVersion = "22.05";
      overlays = [ rust-overlay.overlay myPkgs.overlay ];
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
          inherit username homeDirectory stateVersion pkgs system;
          configuration = { pkgs, ... }:
            {
              # Setup Nixpkgs overlays and configs.
              nixpkgs.overlays = overlays;

              # Let Home Manager manages itself.
              programs.home-manager.enable = true;

              imports = [
                ./packages.nix
                ./services.nix
              ];
            };
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
