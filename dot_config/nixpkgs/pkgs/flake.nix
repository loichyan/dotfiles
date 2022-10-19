{
  description = "My Nix packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    npmlock2nix_ = {
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
  };

  outputs = { nixpkgs, flake-utils, npmlock2nix_, nixgl-wrapped, ... }:
    let
      mkPkgs = pkgs:
        let
          npmlock2nix = pkgs.callPackage npmlock2nix_ { };
        in
        {
          cz-cli = pkgs.callPackage ./cz-cli.nix { inherit npmlock2nix; };
          prettierd = pkgs.callPackage ./prettierd.nix { };
        };
    in
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = mkPkgs pkgs;
      }
    )) // {
      overlays.default = final: prev: {
        myPkgs = mkPkgs final;
      } // (nixgl-wrapped.overlays.default final prev);
    }
  ;
}
