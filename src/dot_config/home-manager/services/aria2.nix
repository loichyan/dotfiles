{ pkgs, ... }:
let
  inherit (pkgs) aria2;
in
{
  systemd.user.services = {
    aria2 = {
      Unit = {
        Description = aria2.meta.description;
        Wants = "network.target";
        After = "network-online.target";
      };
      Service = {
        Type = "exec";
        Restart = "on-failure";
        ExecStart = "${aria2}/bin/aria2c";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
