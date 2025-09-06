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
            profile_dir=~/.local/state/nix/profiles
            profile_name=$(readlink $profile_dir/profile)
            profile_path=$(readlink -f $profile_dir/$profile_name)
            ln -s $profile_dir/$profile_name /nix/var/nix/gcroots/auto/$(basename $profile_path)
          '';
        };
      }
    );
}
