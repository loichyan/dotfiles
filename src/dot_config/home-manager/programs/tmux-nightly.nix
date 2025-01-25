{ pkgs, ... }:
let
  tmux-nightly =
    with pkgs;
    tmux.overrideAttrs (
      final: prev: {
        version = "00894d1";
        src = fetchFromGitHub {
          owner = "tmux";
          repo = "tmux";
          rev = "00894d188d2a60767a80ae749e7c3fc810fca8cd";
          hash = "sha256-aMXYBMmcRap8Q28K/8/2+WTnPxcF7MTu1Tr85t+zliU=";
        };
      }
    );
in
{
  # TODO: back to the next stable release
  home.packages = [ tmux-nightly ];
}
