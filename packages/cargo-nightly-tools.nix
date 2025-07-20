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
      text = ''cargo-${name} "$@"'';
    };
in
pkgs.symlinkJoin {
  name = "cargo-nightly-tools";
  paths = [
    (writeShellApplication {
      name = "cargo-nightly";
      runtimeInputs = [ rust-nightly ];
      text = ''cargo "$@"'';
    })
    (writeShellApplication {
      name = "rustfmt-nightly";
      runtimeInputs = [ rust-nightly ];
      text = ''rustfmt "$@"'';
    })
    (wrapNightly "expand")
    (wrapNightly "llvm-cov")
    (wrapNightly "udeps")
    (wrapNightly "watch")
  ];
}
