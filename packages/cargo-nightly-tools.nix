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
  wrapNightly =
    name:
    writeShellApplication {
      name = "cargo-nightly-${name}";
      runtimeInputs = [
        rust-nightly
        pkgs."cargo-${name}"
      ];
      text = ''cargo ${name} "$@"'';
    };
in
{
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
  cargo-nightly-expand = wrapNightly "expand";
  cargo-nightly-llvm-cov = wrapNightly "llvm-cov";
  cargo-nightly-udpes = wrapNightly "udeps";
  cargo-nightly-watch = wrapNightly "watch";
}
