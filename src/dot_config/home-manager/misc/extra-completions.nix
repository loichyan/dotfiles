{ pkgs, ... }:
let
  inherit (pkgs) stdenv;
  docker-completions = stdenv.mkDerivation {
    name = "pip-completions";
    unpackPhase = "true";
    buildPhase = "true";
    installPhase = ''
      mkdir -p $out/share/fish/vendor_completions.d
      cp ${pkgs.docker-client}/share/fish/vendor_completions.d/* $out/share/fish/vendor_completions.d
    '';
  };
in
{
  home.packages = [ docker-completions ];
}
