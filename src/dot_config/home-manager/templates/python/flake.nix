{
  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        pyLibs = with pkgs; [ stdenv.cc.cc ];
      in
      {
        devShells.default = with pkgs; mkShell {
          buildInputs = [ python3 ];
          shellHook = ''
            export LD_LIBRARY_PATH=${lib.makeLibraryPath pyLibs}:$LD_LIBRARY_PATH
          '';
        };
      }
    )
  ;
}
