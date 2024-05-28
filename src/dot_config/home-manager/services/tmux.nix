{ pkgs, ... }:
let
  inherit (pkgs) tmux;

  mkTmuxService = name: {
    Unit = {
      Description = "Tmux server (${name})";
    };
    Service = {
      Type = "exec";
      ExecStart = "${tmux}/bin/tmux -DL ${name}";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
in
{
  systemd.user.services = {
    tmux-default = mkTmuxService "default";
    tmux-popup = mkTmuxService "default";
  };
}
