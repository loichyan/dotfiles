{
  # This little flake is inspired by https://github.com/lf-/flakey-profile
  description = "My Nix profile for Termux on Android";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
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
            inherit (nixpkgs) rev narHash;
          in
          pkgs.writeShellScriptBin "pin" ''
            nix registry pin --override-flake nixpkgs "github:NixOS/nixpkgs?rev=${rev}&narHash=${narHash}" nixpkgs
          '';
      }
    );
}
