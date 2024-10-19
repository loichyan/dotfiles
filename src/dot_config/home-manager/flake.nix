{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
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
    # neovim-nightly = {
    #   url = "github:nix-community/neovim-nightly-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixgl,
      nix-index-database,
      fenix,
      fenix-monthly,
      # neovim-nightly,
      ...
    }:
    let
      myData = import ./data.nix;
      username = myData.user;
      overlays = [
        nixgl.overlays.default
        # neovim-nightly.overlays.default
        (_: prev: {
          inherit myData;
          python = prev.python3.withPackages (
            p: with p; [
              ipython
              pip
            ]
          );
          fenix = fenix.packages.${prev.system};
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
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              home = {
                inherit username;
                stateVersion = "23.11";
                homeDirectory = myData.home;
              };
              nix.registry = {
                nixpkgs.to = {
                  type = "path";
                  path = "${nixpkgs}";
                };
                my.to = {
                  type = "path";
                  path = "${self}";
                };
              };
              nixpkgs = {
                inherit overlays;
              };
            }
            nix-index-database.hmModules.nix-index
            ./misc/extra-completions.nix
            ./misc/hm-session-vars.nix
            ./services/aria2.nix
            ./services/geodat.nix
            ./services/sing-box.nix
            ./services/tor.nix
            ./services/xray.nix
            ./programs/cargo-nightly-tools.nix
            ./packages.nix
          ];
        };
      templates = import ./templates.nix;
    };
}
