{ pkgs, ... }:
let
  inherit (pkgs) myData xray aria tor;
in
{
  systemd.user.services = {
    xray = {
      Unit = {
        Description = xray.meta.description;
        After = "network.target";
      };
      Service = {
        Type = "exec";
        Restart = "on-abort";
        ExecStart = "${xray}/bin/xray -confdir ${myData.home}/.config/xray";
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
