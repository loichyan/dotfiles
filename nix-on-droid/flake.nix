{
  # This little flake is inspired by https://github.com/lf-/flakey-profile
  description = "My Nix profile for Termux on Android";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # TODO: remove this input
    nixpkgs-prev.url = "github:NixOS/nixpkgs/648f70160c03151bc2121d179291337ad6bc564b";
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
      nixpkgs-prev,
      flake-utils,
      rust-overlay,
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs-prev = nixpkgs-prev.legacyPackages.${system};

        myRegistry = pkgs.callPackage ./packages/registry.nix {
          inherit inputs;
          lockfile = ./flake.lock;
        };
        myOverlay =
          _: super:
          let
            inherit (super) callPackage;
          in
          {
            inherit (pkgs-prev) dprint;
            tmux-nightly = callPackage ./packages/tmux-nightly.nix { };
            ZxProtoNF = callPackage ./packages/ZxProtoNF.nix { };
          };

        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            rust-overlay.overlays.default
            myOverlay
          ];
        };

        homePackages = pkgs.callPackage ./packages.nix { };
      in
      {
        packages.default =
          with pkgs;
          buildEnv {
            name = "my-nix-profile";
            paths = homePackages ++ [ myRegistry.flake-sync-lock ];
          };
        packages = {
          inherit (pkgs)
            myRegistry
            tmux-nightly
            ZxProtoNF
            ;
          inherit (myRegistry) flake-sync-lock;
          deploy = pkgs.writeShellScriptBin "deploy" ''
            mkdir -p ~/.config/nix/
            cat ${myRegistry.registry} >~/.config/nix/registry.json
          '';
        };
      }
    );
}
