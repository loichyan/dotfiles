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
  };

  outputs = { home-manager, rust-overlay, ... }:
    let
      username = data.user;
      data = import ./data.nix;
      homeDirectory = data.home;
      stateVersion = "22.05";
      overlays = [ rust-overlay.overlay ];
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
    };
}
