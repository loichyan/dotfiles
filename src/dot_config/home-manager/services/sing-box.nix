{ pkgs, ... }:
let
  inherit (pkgs) myData sing-box;
in
{
  systemd.user.services = {
    sing-box = {
      Unit = {
        Description = sing-box.meta.description;
        Wants = "network.target";
        After = "network-online.target";
      };
      Service = {
        Type = "exec";
        Restart = "on-failure";
        ExecStart =
          "${sing-box}/bin/sing-box -C ${myData.home}/.config/sing-box -D ${myData.home}/.local/share/sing-box run";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
