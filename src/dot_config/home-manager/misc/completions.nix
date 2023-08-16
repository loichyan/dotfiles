{ config, lib, pkgs, ... }:
with builtins;
with lib;
let
  cfg = config.misc.completions;
  inherit (pkgs) stdenv babelfish python erdtree;
  pip-completions = stdenv.mkDerivation {
    name = "pip-completions";
    unpackPhase = "true";
    buildPhase = "true";
    installPhase = ''
      mkdir -p $out/share/fish/vendor_completions.d
      ${python}/bin/pip completion --fish \
        >$out/share/fish/vendor_completions.d/pip.fish
    '';
  };
  erdtree-completions = stdenv.mkDerivation {
    name = "erdtree-completions";
    unpackPhase = "true";
    buildPhase = "true";
    installPhase = ''
      mkdir -p $out/share/fish/vendor_completions.d
      ${erdtree}/bin/erd --completions fish \
        >$out/share/fish/vendor_completions.d/erd.fish
    '';
  };
in
{
  options.misc.completions = {
    enable = mkEnableOption "Additional completions";
    pip = mkOption {
      type = types.bool;
      default = true;
    };
    erdtree = mkOption {
      type = types.bool;
      default = true;
    };
  };
  config = mkIf cfg.enable {
    home.packages = mkMerge [
      (mkIf cfg.pip [ pip-completions ])
      (mkIf cfg.erdtree [ erdtree-completions ])
    ]
    ;
  };
}
