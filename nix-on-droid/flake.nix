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
        registry = pkgs.callPackage ./registry.nix { inherit inputs; };
        homePackages = pkgs.callPackage ./packages.nix { };
        dprint-plugins =
          with pkgs.dprint-plugins;
          pkgs.writeText "dprint-plugins" ''
            {
              "plugins": [
                "${dprint-plugin-biome}/plugin.wasm",
                "${dprint-plugin-dockerfile}/plugin.wasm"
                "${dprint-plugin-json}/plugin.wasm",
                "${dprint-plugin-markdown}/plugin.wasm",
                "${g-plane-malva}/plugin.wasm",
                "${g-plane-markup_fmt}/plugin.wasm",
                "${g-plane-pretty_graphql}/plugin.wasm",
                "${g-plane-pretty_yaml}/plugin.wasm"
              ]
            }
          '';
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
          mkdir -p ~/.config/dprint/
          cat ${dprint-plugins} >~/.config/dprint/plugins.json
        '';
      }
    );
}
