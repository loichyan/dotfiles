{ pkgs, ... }:
let
  inherit (pkgs) myData lib aria2;
in
{
  systemd.user.services = lib.optionalAttrs myData.ariaEnabled {
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
