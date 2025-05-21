{
  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) lib mkShellNoCC;

        libPath = lib.makeLibraryPath (
          with pkgs;
          [
            # Required by numpy
            stdenv.cc.cc
            zlib
          ]
        );
      in
      {
        devShells.default = mkShellNoCC {
          packages = with pkgs; [
            python312
            uv
          ];
          shellHook = ''
            export LD_LIBRARY_PATH=${libPath}
          '';
        };
      }
    );
}
