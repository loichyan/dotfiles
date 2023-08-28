{ pkgs, config, lib, ... }:
with builtins;
with lib;
let
  inherit (pkgs) writeShellApplication fenix-monthly cargo-udeps;
  cfg = config.programs.cargo-nightly-udeps;
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
  options.programs.cargo-nightly-udeps = {
    enable = mkEnableOption "cargo-udeps with nightly toolchain";
  };
  config = mkIf cfg.enable {
    home.packages = [ cargo-nightly-udeps ];
  };
}
