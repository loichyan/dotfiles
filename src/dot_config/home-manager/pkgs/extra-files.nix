{ pkgs, stdenv, fenix }:
let
  # Most common derivation.
  rust = with pkgs.fenix; combine [
    stable.defaultToolchain
    stable.rust-src
  ];
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
