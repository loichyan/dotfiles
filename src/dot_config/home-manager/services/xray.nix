{ config, lib, pkgs, ... }:
with builtins;
with lib;
let
  cfg = config.services.xray;
  inherit (pkgs) myData writeScript xray;
  updateGeodat = writeScript "geodat"
    ''
      #!/usr/bin/env bash
      mkdir -p ${myData.home}/.local/share/xray
      curl -L https://ghproxy.com/https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -o ${myData.home}/.local/share/xray/geoip.dat
      curl -L https://ghproxy.com/https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -o ${myData.home}/.local/share/xray/geosite.dat
    '';
in
{
  options.services.xray = {
    enable = mkEnableOption "XRay proxy server";
  };
  config = mkIf cfg.enable {
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
          ExecStart = "${updateGeodat}";
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
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    };
  };
}
