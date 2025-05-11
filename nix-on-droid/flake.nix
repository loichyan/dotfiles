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
      in
      {
        packages.default =
          with pkgs;
          buildEnv {
            name = "my-nix-profile";
            paths = callPackage ./packages.nix { };
          };
        packages.pin =
          let
            inherit (nixpkgs) rev narHash lastModified;
          in
          pkgs.writeShellScriptBin "pin" ''
            nix registry pin --override-flake nixpkgs "github:NixOS/nixpkgs?rev=${rev}&narHash=${narHash}&lastModified=${toString lastModified}" nixpkgs
          '';
      }
    );
}
