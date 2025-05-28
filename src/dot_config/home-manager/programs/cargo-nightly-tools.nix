{ pkgs, ... }:
let
  inherit (pkgs) writeShellApplication rust-bin;
  rust-nightly = rust-bin.selectLatestNightlyWith (
    toolchain:
    toolchain.minimal.override {
      extensions = [
        "clippy"
        "llvm-tools"
        "miri"
        "rust-src"
        "rustfmt"
      ];
    }
  );
  cargo-nightly = writeShellApplication {
    name = "cargo-nightly";
    runtimeInputs = [ rust-nightly ];
    text = ''cargo "$@"'';
  };
  rustfmt-nightly = writeShellApplication {
    name = "rustfmt-nightly";
    runtimeInputs = [ rust-nightly ];
    text = ''rustfmt "$@"'';
  };
  cargoCommand =
    {
      name,
      pkg ? pkgs."cargo-${name}",
    }:
    writeShellApplication {
      name = "cargo-nightly-${name}";
      runtimeInputs = [
        rust-nightly
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
