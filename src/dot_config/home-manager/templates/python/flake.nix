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
        inherit (pkgs) lib;

        ldPaths = lib.makeLibraryPath (with pkgs; [ stdenv.cc.cc ]);
      in
      {
        devShells.default =
          with pkgs;
          mkShell {
            packages = [ python3 ];
            shellHook = ''
              export LD_LIBRARY_PATH=${ldPaths}:$LD_LIBRARY_PATH
            '';
          };
      }
    );
}
