{
  # This little flake is inspired by https://github.com/lf-/flakey-profile
  description = "My Nix profile for Termux on Android";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # TODO: remove this input
    nixpkgs-dprint.url = "github:NixOS/nixpkgs/648f70160c03151bc2121d179291337ad6bc564b";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-dprint,
      flake-utils,
      rust-overlay,
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs-dprint = nixpkgs-dprint.legacyPackages.${system};
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            rust-overlay.overlays.default
            (_: prev: { inherit (pkgs-dprint) dprint; })
          ];
        };

        registry = pkgs.callPackage ./packages/registry.nix {
          inherit inputs;
          lockfile = ./flake.lock;
        };
        homePackages = pkgs.callPackage ./packages.nix { };
      in
      {
        packages.default =
          with pkgs;
          buildEnv {
            name = "my-nix-profile";
            paths = homePackages ++ [ registry.flake-sync-lock ];
          };
        packages.flake-sync-lock = registry.flake-sync-lock;
        packages.deploy = pkgs.writeShellScriptBin "deploy" ''
          mkdir -p ~/.config/nix/
          cat ${registry.registry} >~/.config/nix/registry.json
        '';
      }
    );
}
