{ config, pkgs, ... }:
let
  inherit (pkgs) stdenv;
  hm-session-vars = stdenv.mkDerivation {
    name = "hm-session-vars";
    unpackPhase = "true";
    buildPhase = "true";
    # https://github.com/nix-community/home-manager/blob/8f6ca7855d409aeebe2a582c6fd6b6a8d0bf5661/modules/programs/fish.nix#L223
    installPhase = ''
      mkdir -p $out/etc/profile.d
      {
        echo "function setup_hm_session_vars;"
        ${pkgs.buildPackages.babelfish}/bin/babelfish <${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh
        echo "end"
        echo "setup_hm_session_vars"
      }>$out/etc/profile.d/hm-session-vars.fish
    '';
  };
in
{
  home.packages = [ hm-session-vars ];
}
