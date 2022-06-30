{ pkgs, lib, stdenv }:
let
  pname = "akmods-keys";
  version = "0.1.0";
in
stdenv.mkDerivation {
  inherit pname version;
  nativeBuildInputs = with pkgs; [ fpm rpm fakeroot ];
  src = ./.;
  buildPhase = ''
    # Copy files
    confdir=rootfs/etc
    mkdir -p \
      $confdir/pki/${pname}/certs \
      $confdir/pki/${pname}/private \
      $confdir/rpm
    install -pm 0640 public_key.der $confdir/pki/${pname}/certs
    install -pm 0640 private_key.priv $confdir/pki/${pname}/private
    install -pm 0640 macros.kmodtool $confdir/rpm
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
      --rpm-tag "Supplements: akmods"
  '';
  installPhase = ''
    mv out $out
  '';
}
