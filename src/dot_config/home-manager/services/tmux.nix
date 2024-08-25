{ pkgs, ... }:
let
  inherit (pkgs) tmux writeShellApplication;

  tmux-start-server = writeShellApplication {
    name = "tmux-start-server";
    # make sure tmux is in $PATH
    runtimeInputs = [ tmux ];
    text = "tmux new-session -ds main";
  };
in
{
  systemd.user.services = {
    tmux-server = {
      Unit = {
        Description = "tmux server";
      };
      # adapted from: https://github.com/tmux-plugins/tmux-continuum/blob/0698e8f4b17d/scripts/handle_tmux_automatic_start/systemd_enable.sh#L20
      Service = {
        Type = "forking";
        KillMode = "control-group";

        ExecStart = "${tmux-start-server}/bin/tmux-start-server";
        ExecStop = "${tmux}/bin/tmux kill-server";

        RestartSec = 2;
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
