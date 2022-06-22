{
  description = "My Nix packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    npmlock2nix_ = {
      url = "github:nix-community/npmlock2nix";
      flake = false;
    };
  };

  outputs = { nixpkgs, flake-utils, npmlock2nix_, ... }:
    let
      mkPkgs = pkgs:
        let
          npmlock2nix = pkgs.callPackage npmlock2nix_ { };
        in
        {
          cz-cli = pkgs.callPackage ./cz-cli.nix { inherit npmlock2nix; };
          prettierd = pkgs.callPackage ./prettierd.nix { };
        };
      overlay = final: _: {
        myPkgs = mkPkgs final;
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
      inherit overlay;
      overlays.default = overlay;
    }
  ;
}
