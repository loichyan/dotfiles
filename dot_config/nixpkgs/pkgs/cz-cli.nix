{ lib, stdenv, fetchFromGitHub, npmlock2nix }:
let
  name = "cz-cli";
  version = "v4.2.4";
  node_module = npmlock2nix.v1.node_modules {
    inherit name version;
    src = fetchFromGitHub {
      owner = "commitizen";
      repo = name;
      rev = version;
      sha256 = "sha256-4Yj5hWY4DQcYlyx1XJxPAJdV3+s1G0kRyVne6hUxROc=";
    };
  };
in
stdenv.mkDerivation {
  inherit name version;
  buildInputs = [ node_module ];
  unpackPhase = "true";
  installPhase = ''
    mkdir -p $out/bin
    bin=${node_module}/node_modules/.bin
    ln -s $bin/git-cz $out/bin/cz
    ln -s $bin/git-cz $out/bin/git-cz
    ln -s $bin/commitizen $out/bin/commitizen
  '';
}
