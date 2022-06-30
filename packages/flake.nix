{
  description = "My local system packages.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        packages = {
          symbols-nerd-font = pkgs.callPackage ./symbols-nerd-font { };
          nix-single-user = pkgs.callPackage ./nix-single-user { };
          akmods-keys = pkgs.callPackage ./akmods-keys { };
        };
      in
      {
        packages = {
          default =
            pkgs.buildEnv {
              name = "my-packages";
              paths = builtins.attrValues packages;
            };
        } // packages;
      }
    )
  ;
}
