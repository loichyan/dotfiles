{ pkgs, ... }:
let
  inherit (pkgs) tor;
in
{
  systemd.user.services = {
    tor = {
      Unit = {
        Description = tor.meta.description;
        Wants = "network.target";
        After = "network-online.target";
      };
      Service = {
        Type = "exec";
        Restart = "on-failure";
        ExecStart = "${tor}/bin/tor";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
