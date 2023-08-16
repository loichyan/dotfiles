{ config, lib, pkgs, ... }:
with builtins;
with lib;
let
  cfg = config.services.xray;
  inherit (pkgs) myData aria;
in
{
  options.services.aria = {
    enable = mkEnableOption "Aria2 RPC server";
  };
  config = mkIf cfg.enable {
    systemd.user.services = {
      aria2 = {
        Unit = {
          Description = aria.meta.description;
          After = "network.target";
        };
        Service = {
          Type = "exec";
          Restart = "on-abort";
          ExecStart = "${aria}/bin/aria2c";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    };
  };
}
