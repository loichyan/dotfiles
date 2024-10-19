{ pkgs, ... }:
let
  inherit (pkgs) lib myData sing-box;
  enabled = myData.proxyEnabled && (myData.proxyBackend == "sing-box");
in
{
  home.packages = lib.optional enabled pkgs.sing-box;
  systemd.user.services = lib.optionalAttrs enabled {
    sing-box = {
      Unit = {
        Description = sing-box.meta.description;
        Wants = "network.target";
        After = "network-online.target";
      };
      Service = {
        Type = "exec";
        Restart = "on-failure";
        ExecStart = "${sing-box}/bin/sing-box -C ${myData.home}/.config/sing-box -D ${myData.home}/.local/share/sing-box run";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
