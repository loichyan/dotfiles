{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShellNoCC;
      in
      {
        devShells.default = mkShellNoCC {
          packages = with pkgs; [ ];
          shellHook = '''';
        };
      }
    );
}
