{ pkgs, ... }:
let
  inherit (pkgs)
    lib
    myData
    curl
    jq
    writeShellApplication
    ;
  update-geodat = writeShellApplication {
    name = "update-geodat";
    runtimeInputs = [
      curl
      jq
    ];
    text = ''
      if [[ ! -f ~/.config/xray/config.json ]]; then exit; fi
      mkdir -p ~/.local/share/xray
      while IFS=$'\t' read -r name url; do
        curl -fL "$url" -o "$HOME/.local/share/xray/$name.dat"
      done < <(jq -r '.ruleset.[] | "\(.name)\t\(.url)"' ~/.config/xray/config.json)
    '';
  };
in
{
  systemd.user.services = lib.optionalAttrs myData.geodatEnabled {
    geodat = {
      Unit = {
        Description = "Download geodat";
        After = "network.target";
      };
      Service = {
        Type = "exec";
        ExecStart = "${update-geodat}/bin/update-geodat";
      };
    };
  };
  systemd.user.timers = lib.optionalAttrs myData.geodatEnabled {
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

}
