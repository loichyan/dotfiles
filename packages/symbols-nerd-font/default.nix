{ pkgs, lib, stdenv, fetchurl }:
let
  pname = "symbols-nerd-font";
  version = "2.2.0-RC";
  fonts = {
    "NerdFontsSymbolsOnly" = lib.fakeSha256;
  };
in
stdenv.mkDerivation {
  inherit pname version;
  nativeBuildInputs = with pkgs; [ unzip fpm rpm fakeroot ];
  src = fetchurl {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/${version}/NerdFontsSymbolsOnly.zip";
    sha256 = "sha256-dEB0hwl9tCb4jfQ8frh79IUH44rY8cMzi6HIMWNEWu8=";
  };
  unpackPhase = ''
    mkdir fonts
    unzip $src "*.ttf" ".otf" -x "*Windows Compatible.*" -d fonts || true
  '';
  buildPhase = ''
    # Copy fonts
    font_dir=rootfs/usr/share/fonts
    mkdir -p "$font_dir"
    mv fonts "$font_dir/symbols-nerd-font"
    # Copy fontconfig files
    mkdir -p rootfs/usr/share/fontconfig/conf.avail
    mkdir -p rootfs/etc/fonts/conf.d
    fontcfg=usr/share/fontconfig/conf.avail/10-symbols-nerd-font.conf
    cp ${./fontconfig.conf} rootfs/$fontcfg
    ln -s /$fontcfg rootfs/etc/fonts/conf.d
    # Build FPM
    mkdir -p out
    fakeroot fpm \
      -n ${pname} \
      -v ${version} \
      -a all \
      -s dir \
      -t rpm \
      -C rootfs \
      -p out
  '';
  installPhase = ''
    mv out $out
  '';
}
