{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { home-manager, ... }:
    let
      data = import ./data.nix;
      username = data.user;
    in
    {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit username;
        system = "x86_64-linux";
        homeDirectory = data.home;
        stateVersion = "22.05";
        configuration = import ./home.nix;
      };
    };
}
