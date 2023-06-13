{ pkgs, config, lib, ... }:
with builtins;
with lib;
let
  inherit (pkgs) writeShellApplication fenix cargo-expand;
  cfg = config.programs.cargo-nightly-expand;
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
{
  options.programs.cargo-nightly-expand = {
    enable = mkEnableOption "cargo-expand with nightly toolchain";
  };
  config = mkIf cfg.enable {
    home.packages = [ cargo-nightly-expand ];
  };
}
