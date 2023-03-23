{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    myPkgs = {
      url = "./pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.fenix.follows = "fenix";
    };
  };

  outputs = { nixpkgs, home-manager, myPkgs, fenix, ... }:
    let
      data = import ./data.nix;
      username = data.user;
      homeDirectory = data.home;
      stateVersion = "22.11";
      overlays = [
        myPkgs.overlays.default
        fenix.overlays.default
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
          modules = [
            { home = { inherit username homeDirectory stateVersion; }; }
            ./packages.nix
            ./services.nix
          ];
        };
    };
}
