{ pkgs, ... }:
let
  inherit (pkgs) myData aria tor writeScript;
  xray = pkgs.xray-1_7_5;
  geodat = writeScript "geodat"
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
        After = "network.target";
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
    aria2 = {
      Unit = {
        Description = aria.meta.description;
        After = "network.target";
      };
      Service = {
        Type = "exec";
        Restart = "on-abort";
        ExecStart = "${aria}/bin/aria2c";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
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
    geodat = {
      Unit = {
        Description = "Download geodat";
        After = "network.target";
      };
      Service = {
        Environment = [
          "HTTP_PROXY=http://127.0.0.1:${myData.httpProxy}"
          "HTTPS_PROXY=http://127.0.0.1:${myData.httpProxy}"
        ];
        Type = "exec";
        ExecStart = "${geodat}";
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
        OnUnitActiveSec = "*-*-* 00:00:00";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
