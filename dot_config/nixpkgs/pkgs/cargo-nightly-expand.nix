{ pkgs, writeShellApplication, rust-bin, cargo-expand }:
writeShellApplication {
  name = "cargo-nightly-expand";
  runtimeInputs = [
    rust-bin.nightly.latest.minimal
    cargo-expand
  ];
  text = ''
    cargo expand "$@"
  '';
}
