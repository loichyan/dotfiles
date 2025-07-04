{ pkgs }:
let
  varsBash = pkgs.writeTextFile {
    name = "hm-session-vars.sh";
    destination = "/etc/profile.d/hm-session-vars.sh";
    text = ''
      export TZDIR=${pkgs.tzdata}/share/zoneinfo
    '';
  };
  varsFish = pkgs.writeTextFile {
    name = "hm-session-vars.fish";
    destination = "/etc/profile.d/hm-session-vars.fish";
    text = ''
      set -gx TZDIR ${pkgs.tzdata}/share/zoneinfo
    '';
  };
in
pkgs.symlinkJoin {
  name = "hm-session-vars";
  paths = [
    varsBash
    varsFish
  ];
}
