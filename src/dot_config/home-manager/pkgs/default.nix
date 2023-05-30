{ pkgs, fetchFromGitHub }:
{
  cargo-nightly-expand = pkgs.callPackage ./cargo-nightly-expand.nix { };
  xray-1_7_5 = (import
    (fetchFromGitHub {
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8";
      sha256 = "sha256-0gI2FHID8XYD3504kLFRLH3C2GmMCzVMC50APV/kZp8=";
    })
    {
      inherit (pkgs) system;
    }).xray;
}
