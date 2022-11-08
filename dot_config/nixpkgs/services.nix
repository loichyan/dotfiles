{ pkgs, ... }:
let
  inherit (pkgs) clash aria tor;
in
{
  systemd.user.services = {
    clash = {
      Unit = {
        Description = clash.meta.description;
        After = "network.target";
      };
      Service = {
        Type = "exec";
        Restart = "on-abort";
        ExecStart = "${clash}/bin/clash";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
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
}
