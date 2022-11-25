{ pkgs, writeShellApplication, fenix, cargo-expand }:
writeShellApplication {
  name = "cargo-nightly-expand";
  runtimeInputs = [
    fenix.minimal.toolchain
    cargo-expand
  ];
  text = ''
    cargo expand "$@"
  '';
}
