{ pkgs, ... }:
let
  inherit (pkgs) lib myData tor;
in
{
  systemd.user.services = lib.optionalAttrs myData.torEnabled {
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
