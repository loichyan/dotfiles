{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # TODO: no crane
    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { nixpkgs, flake-utils, fenix, crane, ... }:
    let
      mkPkgs = pkgs:
        rec {
          rustToolchain = (with pkgs.fenix; combine [
            stable.defaultToolchain
            stable.rust-src
          ]);
          craneLib = (crane.mkLib pkgs).overrideToolchain rustToolchain;
          myCrate = craneLib.buildPackage {
            src = craneLib.cleanCargoSource (craneLib.path ./.);
          };
        }
      ;
    in
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ fenix.overlays.default ];
        };
        inherit (mkPkgs pkgs) rustToolchain myCrate;
      in
      {
        packages.default = myCrate;
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            rustToolchain
          ];
        };
      }
    )) // {
      overlays.default = _: prev: {
        inherit (mkPkgs prev) myCrate;
      };
    }
  ;
}
