{ pkgs, ... }:
let
  inherit (pkgs) rustPlatform fetchCrate fetchFromGitHub symlinkJoin;
  datafusion-cli =
    rustPlatform.buildRustPackage rec {
      pname = "datafusion-cli";
      version = "31.0.0";
      src = fetchCrate {
        inherit pname version;
        sha256 = "sha256-zsN2BUFrTOmB1ey1tkGetTiSI9N/thzi3vpkfNFv6hU=";
      };
      cargoHash = "sha256-j4SCFwz5KD71tpSU3eYBY6+N5aiVhFIpw9rcJPcCbec=";
    };
in
{
  home.packages = [
    datafusion-cli
    pkgs.pqrs
  ];
}
