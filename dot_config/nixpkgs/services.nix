{ pkgs, ... }:
{
  systemd.user.services = {
    clash = {
      Unit = {
        Description = "A rule based proxy in Go.";
        After = "network.target";
      };
      Service = {
        Type = "exec";
        Restart = "on-abort";
        ExecStart = "${pkgs.clash}/bin/clash";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
