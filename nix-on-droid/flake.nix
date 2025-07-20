{
  # This little flake is inspired by https://github.com/lf-/flakey-profile
  description = "My Nix profile for Termux on Android";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
      flake-utils,
      rust-overlay,
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];
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
