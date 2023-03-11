{ pkgs, stdenv, fenix }:
let
  rust = fenix.stable.defaultToolchain;
in
stdenv.mkDerivation {
  name = "extra-files";
  unpackPhase = "true";
  buildPhase = "true";
  installPhase = ''
    mkdir -p $out
    ln -s ${rust}/etc $out/etc
    ln -s ${rust}/share $out/share
  '';
}
