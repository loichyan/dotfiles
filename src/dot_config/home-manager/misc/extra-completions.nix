{ pkgs, ... }:
let
  inherit (pkgs) stdenv python erdtree;
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
in { home.packages = [ pip-completions erdtree-completions ]; }
