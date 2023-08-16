{ config, lib, pkgs, ... }:
with builtins;
with lib;
let
  cfg = config.services.xray;
  inherit (pkgs) myData tor;
in
{
  options.services.tor = {
    enable = mkEnableOption "Tor proxy server";
  };
  config = mkIf cfg.enable {
    systemd.user.services = {
      tor = {
        Unit = {
          Description = tor.meta.description;
          After = "network.target";
        };
        Service = {
          Type = "exec";
          Restart = "on-abort";
          ExecStart = "${tor}/bin/tor";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    };
  };
}
