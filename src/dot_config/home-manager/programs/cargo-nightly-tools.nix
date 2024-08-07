{ pkgs, ... }:
let
  inherit (pkgs)
    writeShellApplication
    fenix-monthly
    cargo-expand
    cargo-udeps
    cargo-watch
    ;
  rustToolchain =
    with fenix-monthly;
    combine [
      default.toolchain
      complete.miri
    ];
  cargo-nightly = writeShellApplication {
    name = "cargo-nightly";
    runtimeInputs = [ rustToolchain ];
    text = ''
      cargo "$@"
    '';
  };
  cargo-nightly-expand = writeShellApplication {
    name = "cargo-nightly-expand";
    runtimeInputs = [
      rustToolchain
      cargo-expand
    ];
    text = ''
      cargo expand "$@"
    '';
  };
  cargo-nightly-udeps = writeShellApplication {
    name = "cargo-nightly-udeps";
    runtimeInputs = [
      rustToolchain
      cargo-udeps
    ];
    text = ''
      cargo udeps "$@"
    '';
  };
  cargo-nightly-watch = writeShellApplication {
    name = "cargo-nightly-watch";
    runtimeInputs = [
      rustToolchain
      cargo-watch
    ];
    text = ''
      cargo watch "$@"
    '';
  };
  rustfmt-nightly = writeShellApplication {
    name = "rustfmt-nightly";
    runtimeInputs = [ rustToolchain ];
    text = ''
      rustfmt "$@"
    '';
  };
in
{
  home.packages = [
    cargo-nightly
    cargo-nightly-expand
    cargo-nightly-udeps
    cargo-nightly-watch
    rustfmt-nightly
  ];
}
