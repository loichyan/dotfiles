{ pkgs, ... }:
let
  inherit (pkgs) myData tor;
in
{
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
}
