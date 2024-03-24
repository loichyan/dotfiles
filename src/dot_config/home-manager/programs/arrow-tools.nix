{ pkgs, ... }:
let
  inherit (pkgs) rustPlatform fetchCrate fetchFromGitHub;
  datafusion-cli = rustPlatform.buildRustPackage rec {
    pname = "datafusion-cli";
    version = "33.0.0";
    src = fetchCrate {
      inherit pname version;
      sha256 = "sha256-YqFZDD48x/RSLE/ZB1oJkY28CG8LEewZQTtFdzFSaLI=";
    };
    cargoHash = "sha256-H/5HEsVL11QSRyLVm3dz0kIn/ygIHvMq+qNgo7cnpNY=";
  };
  arrow-tools = rustPlatform.buildRustPackage rec {
    pname = "arrow-tools";
    version = "0.17.3";
    src = fetchFromGitHub {
      owner = "domoritz";
      repo = "arrow-tools";
      rev = "v${version}";
      sha256 = "sha256-rf5t8qnXcY/CdUfMhRTfGnsavcFkMLfGflB5B1KqT8E=";
    };
    cargoHash = "sha256-tDBDG76zY1vjTNkbpIIVwWPLDhgA/NAXTCABqm95V/A=";
    cargoBuildFlags = [ "--all" ];
  };
in { home.packages = [ arrow-tools datafusion-cli pkgs.pqrs ]; }
