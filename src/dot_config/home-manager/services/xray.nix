{ pkgs, ... }:
let
  inherit (pkgs) lib myData xray;
  enabled = myData.proxyEnabled && (myData.proxyBackend == "xray");
in
{
  home.packages = lib.optional enabled pkgs.xray;
  systemd.user.services = lib.optionalAttrs enabled {
    xray = {
      Unit = {
        Description = xray.meta.description;
        Wants = "network.target";
        After = "network-online.target";
      };
      Service = {
        Type = "exec";
        Restart = "on-failure";
        Environment = lib.optional myData.geodatEnabled "XRAY_LOCATION_ASSET=${myData.home}/.local/share/xray";
        ExecStart = "${xray}/bin/xray run -confdir ${myData.home}/.config/xray";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
