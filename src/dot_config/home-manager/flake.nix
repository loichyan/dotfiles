{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix-monthly = {
      url = "github:nix-community/fenix/monthly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , home-manager
    , fenix
    , fenix-monthly
    , nix-index-database
    , ...
    }:
    let
      data = import ./data.nix;
      stateVersion = "23.05";
      username = data.user;
      homeDirectory = data.home;
      overlays = [
        fenix.overlays.default
        (_: prev: with prev; {
          myData = data;
          python =
            (prev.python3.withPackages (p: with p; [
              black
              ipython
              numpy
              pandas
              pip
            ]));
          fenix-monthly = fenix-monthly.packages.${prev.system};
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
              nix-index-database.hmModules.nix-index
              ./programs/cargo-nightly-expand.nix
              ./programs/cargo-nightly-udeps.nix
              ./services/aria.nix
              ./services/tor.nix
              ./services/xray.nix
              ./misc/completions.nix
              ./misc/hm-session-vars.nix
              ./packages.nix
            ];
          };
    };
}
