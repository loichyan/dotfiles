{ pkgs, ... }:
let
  inherit (pkgs) stdenv;
  docker-completions = stdenv.mkDerivation {
    name = "docker-completions";
    nativeBuildInputs = [ pkgs.docker-client ];
    unpackPhase = "true";
    buildPhase = "true";
    installPhase = ''
      mkdir -p $out/share/fish/vendor_completions.d
      cp ${pkgs.docker-client}/share/fish/vendor_completions.d/* $out/share/fish/vendor_completions.d
    '';
  };
  pnpm-completions = stdenv.mkDerivation {
    name = "pnpm-completions";
    nativeBuildInputs = [ pkgs.pnpm ];
    unpackPhase = "true";
    buildPhase = "true";
    installPhase = ''
      mkdir -p $out/share/fish/vendor_completions.d
      pnpm completion fish >$out/share/fish/vendor_completions.d/pnpm.fish
    '';
  };
in
{
  home.packages = [
    docker-completions
    pnpm-completions
  ];
}
