{
  description = "My Nix packages";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    nixgl-wrapped = {
      url = "./nixgl-wrapped";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, flake-utils, nixgl-wrapped, fenix, ... }:
    let
      overlays = [ fenix.overlays.default ];
      mkPkgs = pkgs: {
        cargo-nightly-expand = pkgs.callPackage ./cargo-nightly-expand.nix { };
      };
    in
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system overlays; };
      in
      { packages = mkPkgs pkgs; }
    )) // {
      overlays.default = final: prev: {
        myPkgs = mkPkgs final;
      } // (nixgl-wrapped.overlays.default final prev);
    }
  ;
}
