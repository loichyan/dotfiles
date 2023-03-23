{
  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    nixgl_ = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, flake-utils, nixgl_, ... }:
    let mkPkgs = pkgs: {
      neovide =
        with pkgs; writeShellScriptBin "neovide"
          ''
            ${nixgl.nixGLIntel}/bin/nixGLIntel ${neovide}/bin/neovide "$@"
          ''
      ;
    }; in
    (
      flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              nixgl_.overlays.default
            ];
          };
        in
        {
          packages = mkPkgs pkgs;
        }
      )
    ) // {
      overlays.default = final: prev:
        let pkgs = final // (nixgl_.overlays.default final prev);
        in
        {
          nixgl-wrapped = mkPkgs pkgs;
        };
    }
  ;
}
