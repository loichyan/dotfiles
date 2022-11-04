{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, flake-utils, rust-overlay, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];
        };
        llvmPkgs = pkgs.llvmPackages;
        mkShell = pkgs.mkShell.override { stdenv = llvmPkgs.stdenv; };
      in
      {
        devShells.default = mkShell (with pkgs; {
          nativeBuildInputs = [
            (rust-bin.stable.latest.default.override {
              extensions = [ "rust-src" ];
            })
            llvmPkgs.bintools
          ];
          NIX_CFLAGS_LINK = "-fuse-ld=lld";
          RUSTFLAGS = [ "-Clinker=clang" "-Clink-arg=-fuse-ld=lld" ];
        });
      }
    )
  ;
}
