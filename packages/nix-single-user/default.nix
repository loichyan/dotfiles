{ pkgs, lib, stdenv, fetchurl }:
let
  pname = "nix-single-user";
  version = "0.1.0";
in
stdenv.mkDerivation {
  inherit pname version;
  nativeBuildInputs = with pkgs; [ fpm rpm fakeroot ];
  src = ./.;
  buildPhase = ''
    # Copy services
    unitdir=rootfs/usr/lib/systemd/system
    install -m 0755 -d $unitdir
    install -m 0644 nix-mkdir.service $unitdir
    install -m 0644 nix.mount $unitdir
    # Build FPM
    mkdir -p out
    fakeroot fpm \
      -n ${pname} \
      -v ${version} \
      -a all \
      -s dir \
      -t rpm \
      -C rootfs \
      -p out \
      --rpm-use-file-permissions
  '';
  installPhase = ''
    mv out $out
  '';
}
