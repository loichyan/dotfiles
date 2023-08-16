{ config, lib, pkgs, ... }:
with builtins;
with lib;
let
  cfg = config.misc.hm-session-vars;
  inherit (pkgs) stdenv babelfish;
  hm-session-vars = stdenv.mkDerivation {
    name = "hm-session-vars";
    unpackPhase = "true";
    buildPhase = "true";
    installPhase = ''
      mkdir -p $out/etc/profile.d
      ${babelfish}/bin/babelfish \
        <${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh \
        >$out/etc/profile.d/hm-session-vars.fish
    '';
  };
in
{
  options.misc.hm-session-vars = {
    enable = mkEnableOption "Home Manager session variables";
  };
  config = mkIf cfg.enable {
    home.packages = [ hm-session-vars ];
  };
}
