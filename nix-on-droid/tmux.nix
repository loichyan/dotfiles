{ pkgs }:
with pkgs;
tmux.overrideAttrs (
  final: prev: {
    version = "3d2b26d";
    src = fetchFromGitHub {
      owner = "tmux";
      repo = "tmux";
      rev = "3d2b26dcfe1a14b5ff6e04121e933a30652c2fe9";
      hash = "sha256-v+d+xxtJOMpZN6qkdgVKKraupj5CPkJd7XP4WR2lJQg=";
    };
  }
)
