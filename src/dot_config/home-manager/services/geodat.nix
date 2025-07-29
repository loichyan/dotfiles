{ pkgs, ... }:
let
  inherit (pkgs)
    lib
    myData
    curl
    writeShellApplication
    ;
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
  systemd.user.services = lib.optionalAttrs myData.geodatEnabled {
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
  systemd.user.timers = lib.optionalAttrs myData.geodatEnabled {
    geodat = {
      Unit = {
        Description = "Auto download geodat";
        After = "network.target";
      };
      Timer = {
        OnBootSec = "1h";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };

}
