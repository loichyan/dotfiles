{ pkgs, ... }:
let
  inherit (pkgs) myData writeScript xray;
  updateGeodat = writeScript "geodat"
    ''
      #!/usr/bin/env bash
      mkdir -p ${myData.home}/.local/share/xray
      curl -L https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -o ${myData.home}/.local/share/xray/geoip.dat
      curl -L https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -o ${myData.home}/.local/share/xray/geosite.dat
    '';
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
        Environment = [
          "XRAY_LOCATION_CONFDIR=${myData.home}/.config/xray"
          "XRAY_LOCATION_ASSET=${myData.home}/.local/share/xray"
        ];
        Type = "exec";
        Restart = "on-abort";
        ExecStart = "${xray}/bin/.xray-wrapped";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
    geodat = {
      Unit = {
        Description = "Download geodat";
        After = "network.target";
      };
      Service = {
        Environment = [
          "http_proxy=http://127.0.0.1:${myData.httpProxy}"
          "https_proxy=http://127.0.0.1:${myData.httpProxy}"
        ];
        Type = "exec";
        ExecStart = "${updateGeodat}";
      };
    };
  };
  systemd.user.timers = {
    geodat = {
      Unit = {
        Description = "Auto download geodat";
        Wants = "network.target";
        After = "network-online.target";
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
