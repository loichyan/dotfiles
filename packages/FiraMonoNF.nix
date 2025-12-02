{
  nerd-font-patcher,
  stdenv,
  fetchzip,
}:
let
  inherit (builtins) replaceStrings;
  version = "3.2";
  version_suffix = replaceStrings [ "." ] [ "_" ] version;
in
stdenv.mkDerivation {
  pname = "FiraMonoNF";
  inherit version;
  src = fetchzip {
    url = "https://carrois.com/downloads/Fira/Fira_Mono_${version_suffix}.zip";
    hash = "sha256-Ukc+K2sdSz+vUQFD8mmwJHZQ3N68oM4fk6YzGLwzAfQ=";
    stripRoot = true;
  };
  nativeBuildInputs = [ nerd-font-patcher ];
  buildPhase = ''
    mkdir out
    find -name "FiraMono-*.ttf" -exec nerd-font-patcher --mono -out out -c {} \;
  '';
  installPhase = ''
    install -Dm644 out/* -t $out/share/fonts/truetype/FiraMonoNF
  '';
}
