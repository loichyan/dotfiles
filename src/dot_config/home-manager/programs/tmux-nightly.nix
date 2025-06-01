{ pkgs, ... }:
let
  tmux-nightly =
    with pkgs;
    tmux.overrideAttrs (
      final: prev: {
        version = "1dbceaa";
        src = fetchFromGitHub {
          owner = "tmux";
          repo = "tmux";
          rev = "1dbceaa790f584b09855005bcfd11297a820f88a";
          hash = "sha256-sYR6qvuEBftFoy+3jIc2+jbr/chlmXTLlMqaZviEx9U=";
        };
      }
    );
in
{
  # TODO: back to the next stable release
  home.packages = [ tmux-nightly ];
}
