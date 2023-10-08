{ config, pkgs, ... }:
let
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
  home.packages = [ hm-session-vars ];
}
