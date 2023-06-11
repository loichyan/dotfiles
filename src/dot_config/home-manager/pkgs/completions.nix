{ pkgs, ... }:
let
  inherit (pkgs) stdenv babelfish myPkgs;
  pip-completions = stdenv.mkDerivation {
    name = "pip-completions";
    unpackPhase = "true";
    buildPhase = "true";
    installPhase = ''
      mkdir -p $out/share/fish/vendor_completions.d
      ${myPkgs.python3}/bin/pip completion --fish \
        >$out/share/fish/vendor_completions.d/pip.fish
    '';
  };
in
{ home.packages = [ pip-completions ]; }
