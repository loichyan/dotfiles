{ pkgs, lib, mkYarnPackage, fetchFromGitHub }:
let
  pname = "prettierd";
  version = "v0.21.1";
in
mkYarnPackage {
  inherit pname version;
  src = fetchFromGitHub {
    owner = "fsouza";
    repo = pname;
    rev = version;
    sha256 = "sha256-BEaeXZ8nO2vRFPze+c0EoWaIztpoktwnZz1aIR/OkzU=";
  };
  postBuild = ''
    yarn --offline run build
  '';
}
