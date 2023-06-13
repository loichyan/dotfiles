{ pkgs, config, lib, ... }:
with builtins;
with lib;
let
  cfg = config.misc.completions;
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
{
  options.misc.completions = {
    enable = mkEnableOption "Completions";
  };
  config = mkIf cfg.enable {
    home.packages = [ pip-completions ];
  };
}
