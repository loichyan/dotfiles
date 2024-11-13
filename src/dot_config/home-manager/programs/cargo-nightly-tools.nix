{ pkgs, ... }:
let
  inherit (pkgs) writeShellApplication fenix-monthly;
  rustToolchain =
    with fenix-monthly;
    combine [
      default.toolchain
      complete.miri
      complete.llvm-tools
    ];
  cargo-nightly = writeShellApplication {
    name = "cargo-nightly";
    runtimeInputs = [ rustToolchain ];
    text = ''
      cargo "$@"
    '';
  };
  rustfmt-nightly = writeShellApplication {
    name = "rustfmt-nightly";
    runtimeInputs = [ rustToolchain ];
    text = ''
      rustfmt "$@"
    '';
  };
  cargoCommand =
    {
      name,
      pkg ? pkgs."cargo-${name}",
    }:
    writeShellApplication {
      name = "cargo-nightly-${name}";
      runtimeInputs = [
        rustToolchain
        pkg
      ];
      text = ''cargo ${name} "$@"'';
    };
  # FIXME: use pkgs.cargo-llvm-cov when https://github.com/NixOS/nixpkgs/pull/353741 is released
  inherit
    (import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/fc6278d271c7e23367c9525356e354179b467d3f.tar.gz";
    }) { })
    cargo-llvm-cov
    ;
in
{
  home.packages = [
    cargo-nightly
    rustfmt-nightly
    (cargoCommand { name = "expand"; })
    (cargoCommand {
      name = "llvm-cov";
      pkg = cargo-llvm-cov;
    })
    (cargoCommand { name = "udeps"; })
    (cargoCommand { name = "watch"; })
  ];
}
