{ pkgs }:
with pkgs;
tmux.overrideAttrs (
  final: prev: {
    version = "1dbceaa";
    src = fetchFromGitHub {
      owner = "tmux";
      repo = "tmux";
      rev = "1dbceaa790f584b09855005bcfd11297a820f88a";
      hash = "sha256-v+d+xxtJOMpZN6qkdgVKKraupj5CPkJd7XP4WR2lJQg=";
    };
  }
)
