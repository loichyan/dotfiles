{ pkgs, ... }:
let
  inherit (pkgs) myData xray;
in
{
  systemd.user.services = {
    xray = {
      Unit = {
        Description = xray.meta.description;
        Wants = "network.target";
        After = "network-online.target";
      };
      Service = {
        Type = "exec";
        Restart = "on-failure";
        Environment = [
          "XRAY_LOCATION_CONFDIR=${myData.home}/.config/xray"
          "XRAY_LOCATION_ASSET=${myData.home}/.local/share/xray"
        ];
        ExecStart = "${xray}/bin/xray run";
      };
      Install = if myData.proxyEnabled then { WantedBy = [ "default.target" ]; } else { };
    };
  };
}
