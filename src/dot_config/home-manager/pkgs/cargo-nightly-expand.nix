{ pkgs, config, ... }:
let
  inherit (pkgs) writeShellApplication fenix cargo-expand;
  cargo-nightly-expand =
    writeShellApplication {
      name = "cargo-nightly-expand";
      runtimeInputs = [
        fenix.minimal.toolchain
        cargo-expand
      ];
      text = ''
        cargo expand "$@"
      '';
    };
in
{ home.packages = [ cargo-nightly-expand ]; }
