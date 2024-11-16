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
in
{
  home.packages = [
    cargo-nightly
    rustfmt-nightly
    (cargoCommand { name = "expand"; })
    (cargoCommand { name = "llvm-cov"; })
    (cargoCommand { name = "udeps"; })
    (cargoCommand { name = "watch"; })
  ];
}
