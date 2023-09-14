{ pkgs, ... }:
let
  inherit (pkgs) writeShellApplication fenix-monthly cargo-expand cargo-udeps;
  cargo-nightly-expand =
    writeShellApplication {
      name = "cargo-nightly-expand";
      runtimeInputs = [
        fenix-monthly.minimal.toolchain
        cargo-expand
      ];
      text = ''
        cargo expand "$@"
      '';
    };
  cargo-nightly-udeps =
    writeShellApplication {
      name = "cargo-nightly-udeps";
      runtimeInputs = [
        fenix-monthly.minimal.toolchain
        cargo-udeps
      ];
      text = ''
        cargo udeps "$@"
      '';
    };
in
{
  home.packages = [
    cargo-nightly-expand
    cargo-nightly-udeps
  ];
}
