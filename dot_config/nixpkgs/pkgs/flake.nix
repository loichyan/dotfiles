{
  description = "My Nix packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    npmlock2nix = {
      url = "github:nix-community/npmlock2nix";
      inputs.nixpkgs.follows = "nixpkgs";
      flake = false;
    };
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

  outputs = { nixpkgs, flake-utils, npmlock2nix, nixgl-wrapped, fenix, ... }:
    let
      overlays = [ fenix.overlays.default ];
      mkPkgs = pkgs:
        let
          npmlock2nix2 = pkgs.callPackage npmlock2nix { };
        in
        {
          cz-cli = pkgs.callPackage ./cz-cli.nix { npmlock2nix = npmlock2nix2; };
          prettierd = pkgs.callPackage ./prettierd.nix { };
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
