{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs";
    home-manager = {
      # TODO: switch back to release-23.05 util #4012 is merged
      # url = "github:nix-community/home-manager/release-23.05";
      url = "github:nix-community/home-manager/53ccbe0";
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
        (_: prev: with prev; {
          myData = data;
          myPkgs = {
            python3 =
              (prev.python3.withPackages (p: with p; [
                black
                ipython
                numpy
                pandas
                pip
              ]));
          };
        })
      ];
    in
    {
      homeConfigurations.${username} =
        let
          system = "x86_64-linux";
          pkgs = nixpkgs.legacyPackages.${system};
        in
        home-manager.lib.homeManagerConfiguration
          {
            inherit pkgs;
            modules = [
              {
                home = { inherit username homeDirectory stateVersion; };
                nixpkgs = { inherit overlays; };
              }
              ./modules/programs/cargo-nightly-expand.nix
              ./modules/misc/completions.nix
              ./modules/misc/hm-session-vars.nix
              ./packages.nix
              ./services.nix
            ];
          };
    };
}
