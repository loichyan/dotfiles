{ pkgs, ... }:
let
  inherit (pkgs) myData curl writeShellApplication;
  update-geodat = writeShellApplication {
    name = "update-geodat";
    runtimeInputs = [ curl ];
    text = ''
      mkdir -p ${myData.home}/.local/share/xray
      curl -fL "${myData.geodatIp}" -o ${myData.home}/.local/share/xray/geoip.dat
      curl -fL "${myData.geodatDomain}" -o ${myData.home}/.local/share/xray/geosite.dat
    '';
  };
in
{
  systemd.user.services = {
    geodat = {
      Unit = {
        Description = "Download geodat";
        After = "network.target";
      };
      Service = {
        Type = "exec";
        ExecStart = "${update-geodat}/bin/update-geodat";
      };
    };
  };
  systemd.user.timers = {
    geodat = {
      Unit = {
        Description = "Auto download geodat";
        After = "network.target";
      };
      Timer = {
        OnBootSec = "1h";
      };
      Install = if myData.geodatEnabled then { WantedBy = [ "default.target" ]; } else { };
    };
  };

}
