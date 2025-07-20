{ pkgs }:
with pkgs;
tmux.overrideAttrs (
  final: prev: {
    version = "1dbceaa";
    src = fetchFromGitHub {
      owner = "tmux";
      repo = "tmux";
      rev = "e7f15d09be61fd0b9d54f6fec2f47ace4008b4dc";
      hash = "sha256-75iHBSZZnH0gZQUv4GbNdTj3hBo6eyIauKPtC/edr9E=";
    };
  }
)
