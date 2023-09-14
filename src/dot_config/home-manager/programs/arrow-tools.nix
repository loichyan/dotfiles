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
  arrow-tools =
    rustPlatform.buildRustPackage rec {
      pname = "arrow-tools";
      version = "0.13.0";
      src = fetchFromGitHub {
        owner = "domoritz";
        repo = "arrow-tools";
        rev = "v${version}";
        sha256 = "sha256-xKjFI3ZtlpIkH94U90NP/SHJK3RX2y5jNmYDi4BweqE=";
      };
      cargoHash = "sha256-6yjNjBC2w0dx/8QqFvaljQJAP0dWLnNur9023HeZ2e4=";
      cargoBuildFlags = [ "--all" ];
    };
in
{
  home.packages = [
    arrow-tools
    datafusion-cli
    pkgs.pqrs
  ];
}
