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
        inherit (pkgs) lib mkShell;

        libPath = lib.makeLibraryPath (with pkgs; [ stdenv.cc.cc ]);
      in
      {
        devShells.default = mkShell {
          packages = with pkgs; [ python3 ];
          shellHook = ''
            export LD_LIBRARY_PATH=${libPath}:$LD_LIBRARY_PATH
          '';
        };
      }
    );
}
