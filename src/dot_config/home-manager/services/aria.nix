{ pkgs, ... }:
let
  inherit (pkgs) myData aria;
in
{
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
}
