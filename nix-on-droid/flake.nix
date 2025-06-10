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
        inherit (pkgs) lib;
      in
      rec {
        packages.default =
          with pkgs;
          buildEnv {
            name = "my-nix-profile";
            paths = callPackage ./packages.nix { };
          };
        packages.registry =
          let
            lockfile = lib.importJSON ./flake.lock;
            nodes = builtins.mapAttrs (name: node: {
              from.type = "indirect";
              from.id = name;
              to = node.locked;
            }) lockfile.nodes;
            registry = {
              version = 2;
              flakes = builtins.filter (node: builtins.hasAttr node.from.id inputs) (builtins.attrValues nodes);
            };
          in
          pkgs.writeText "registry" (builtins.toJSON registry);
        packages.pin = pkgs.writeShellScriptBin "pin" ''cat ${packages.registry} >~/.config/nix/registry.json'';
      }
    );
}
