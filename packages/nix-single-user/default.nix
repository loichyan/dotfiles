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
    service_dir=rootfs/usr/lib/systemd
    mkdir -p "$service_dir"
    mv system $service_dir
    # Build FPM
    mkdir -p out
    fakeroot fpm \
      -n ${pname} \
      -v ${version} \
      -a ${stdenv.targetPlatform.linuxArch} \
      -s dir \
      -t rpm \
      -C rootfs \
      -p out
  '';
  installPhase = ''
    mv out $out
  '';
}
