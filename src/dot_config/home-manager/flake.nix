{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixGL = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    myPkgs = {
      url = "./pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.fenix.follows = "fenix";
    };
  };

  outputs = { nixpkgs, home-manager, myPkgs, fenix, nixGL, ... }:
    let
      data = import ./data.nix;
      username = data.user;
      homeDirectory = data.home;
      stateVersion = "22.11";
      overlays = [
        fenix.overlays.default
        nixGL.overlays.default
        myPkgs.overlays.default
        (_: _: { myData = data; })
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
          nixpkgs.config.allowUnfree = true;
          modules = [
            { home = { inherit username homeDirectory stateVersion; }; }
            ./packages.nix
            ./services.nix
          ];
        };
    };
}
