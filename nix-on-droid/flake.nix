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
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];
        };
        inherit (pkgs) lib;

        lockfile = lib.importJSON ./flake.lock;
        inputs = builtins.filter (item: builtins.hasAttr item.name lockfile.nodes.root.inputs) (
          lib.mapAttrsToList (name: node: {
            name = name;
            value = node.locked;
          }) lockfile.nodes
        );
      in
      rec {
        packages.default =
          with pkgs;
          buildEnv {
            name = "my-nix-profile";
            paths = callPackage ./packages.nix { };
          };
        packages.registry = pkgs.writeText "registry" (
          builtins.toJSON {
            version = 2;
            flakes = builtins.map (
              { name, value }:
              {
                from.type = "indirect";
                from.id = name;
                to = value;
              }
            ) inputs;
          }
        );
        /**
          Pins all flake inputs to the local registry.
        */
        packages.pin = pkgs.writeShellScriptBin "pin" ''
          cat ${packages.registry} >~/.config/nix/registry.json
        '';
        /**
          Updates the current flake inputs to the same as the global inputs.
        */
        packages.flake-lock =
          let
            overrides = builtins.map (
              { name, value }: "--override-input ${name} ${builtins.flakeRefToString value}"
            ) inputs;
          in
          pkgs.writeShellScriptBin "flake-lock" ''
            nix flake lock ${builtins.concatStringsSep " " overrides}
          '';
      }
    );
}
