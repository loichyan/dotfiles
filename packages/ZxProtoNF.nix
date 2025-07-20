{
  nerd-font-patcher,
  stdenv,
  fetchzip,
}:
let
  inherit (builtins) replaceStrings;
  version = "2.500";
  version_suffix = replaceStrings [ "." ] [ "_" ] version;
in
stdenv.mkDerivation {
  pname = "0xProtoNF";
  inherit version;
  src = fetchzip {
    url = "https://github.com/0xType/0xProto/releases/download/${version}/0xProto_${version_suffix}.zip";
    hash = "sha256-AmD5lUV341222gu/cCLnKWO87mjPn7gFkeklrV3OlOs=";
    stripRoot = false;
  };
  nativeBuildInputs = [ nerd-font-patcher ];
  buildPhase = ''
    mkdir out
    find -name "0xProto-*.ttf" -exec nerd-font-patcher -out out -c {} \;
  '';
  installPhase = ''
    install -Dm644 out/* -t $out/share/fonts/0xProtoNF
  '';
}
