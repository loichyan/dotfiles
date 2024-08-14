{ pkgs, ... }:
let
  inherit (pkgs) tmux writeShellApplication;

  mkTmuxService =
    name:
    let
      tmux-start = writeShellApplication {
        name = "tmux-start";
        # make sure tmux is in $PATH
        runtimeInputs = [ tmux ];
        text = "tmux -L ${name} new-session -s main -d";
      };
    in
    {
      Unit = {
        Description = "tmux server (${name})";
      };
      # adapted from: https://github.com/tmux-plugins/tmux-continuum/blob/0698e8f4b17d/scripts/handle_tmux_automatic_start/systemd_enable.sh#L20
      Service = {
        Type = "forking";

        WorkingDirectory = pkgs.myData.home;
        ExecStart = "${tmux-start}/bin/tmux-start";

        ExecStop = "${tmux}/bin/tmux -L ${name} kill-server";
        KillMode = "control-group";

        RestartSec = 2;
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
in
{
  systemd.user.services = {
    tmux-default = mkTmuxService "default";
    tmux-popup = mkTmuxService "popup";
  };
}
