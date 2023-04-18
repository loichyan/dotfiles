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
    pkgs-xray-1_7_5.url = "github:NixOS/nixpkgs/8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8";
  };

  outputs = { nixpkgs, flake-utils, nixgl-wrapped, fenix, pkgs-xray-1_7_5, ... }:
    let
      overlays = [ fenix.overlays.default ];
      mkPkgs = pkgs: {
        cargo-nightly-expand = pkgs.callPackage ./cargo-nightly-expand.nix { };
        extra-files = pkgs.callPackage ./extra-files.nix { };
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
        xray-1_7_5 = pkgs-xray-1_7_5.legacyPackages.${prev.system}.xray;
      } // (nixgl-wrapped.overlays.default final prev);
    }
  ;
}
