{ pkgs, }:
{
  cargo-nightly-expand = pkgs.callPackage ./cargo-nightly-expand.nix { };
}
