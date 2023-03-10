{ pkgs, lib, stdenv, fetchurl }:
let
  pname = "symbols-nerd-font";
  version = "2.3.3";
  fonts = {
    "NerdFontsSymbolsOnly" = lib.fakeSha256;
  };
in
stdenv.mkDerivation {
  inherit pname version;
  nativeBuildInputs = with pkgs; [ unzip fpm rpm fakeroot ];
  src = fetchurl {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/NerdFontsSymbolsOnly.zip";
    sha256 = "sha256-nPDIAN6GvDHxEVsPR2LvjYCnSfbPpM90E7AfxWPMP2o=";
  };
  fontconfig_file = fetchurl {
    url = "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/10-nerd-font-symbols.conf";
    sha256 = "sha256-HrnGZnURiaQWZpkGqU+zE/CW8bs2s3x8b0MRjBpl5x8=";
  };
  unpackPhase = ''
    mkdir fonts
    unzip $src "*.ttf" ".otf" -x "*Windows Compatible.*" -d fonts || true
  '';
  buildPhase = ''
    # Copy fonts
    fontdir=usr/share/fonts/symbols-nerd-font
    install -m 0755 -d rootfs/$fontdir
    install -m 0644 -p fonts/* rootfs/$fontdir
    # Copy fontconfig files
    fontcfg_tmpldir=usr/share/fontconfig/conf.avail
    fontcfg_confdir=etc/fonts/conf.d
    install -m 0755 -d \
      rootfs/$fontcfg_tmpldir \
      rootfs/$fontcfg_confdir
    fontconf=$fontcfg_tmpldir/10-symbols-nerd-font.conf
    install -m 0644 -p $fontconfig_file rootfs/$fontconf
    ln -s /$fontconf rootfs/$fontcfg_confdir
    # Copy metainfo
    install -Dm 0644 -p ${./metainfo.xml} rootfs/usr/share/metainfo/${pname}.metainfo.xml
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
