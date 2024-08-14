{ pkgs, ... }:
let
  inherit (pkgs) myData tor;
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
      Install = if myData.torEnabled then { WantedBy = [ "default.target" ]; } else { };
    };
  };
}
