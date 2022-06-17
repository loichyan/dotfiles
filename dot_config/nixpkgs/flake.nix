{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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

  outputs = { home-manager, rust-overlay, myPkgs, ... }:
    let
      username = data.user;
      data = import ./data.nix;
      homeDirectory = data.home;
      stateVersion = "22.05";
      overlays = [ rust-overlay.overlay myPkgs.overlay ];
    in
    {
      homeConfigurations."${username}" =
        home-manager.lib.homeManagerConfiguration {
          inherit username homeDirectory stateVersion;
          system = "x86_64-linux";
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
          description = "Basic nix project";
        };
      };
    };
}
