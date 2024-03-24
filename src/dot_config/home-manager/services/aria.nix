{ pkgs, ... }:
let inherit (pkgs) myData aria;
in {
  systemd.user.services = {
    aria2 = {
      Unit = {
        Description = aria.meta.description;
        Wants = "network.target";
        After = "network-online.target";
      };
      Service = {
        Type = "exec";
        Restart = "on-failure";
        ExecStart = "${aria}/bin/aria2c";
      };
      Install = { WantedBy = [ "default.target" ]; };
    };
  };
}
