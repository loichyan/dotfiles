{ tmux, fetchFromGitHub }:
tmux.overrideAttrs (
  self: super: {
    version = "fa63088";
    src = fetchFromGitHub {
      owner = "tmux";
      repo = "tmux";
      rev = "fa63088dceab9b9397d5cfde83b19839a6a881d7";
      hash = "sha256-vcBMdGgHEKlh6UuzoStPTmZt9KIM9AQZLH7fCpVii6s=";
    };
  }
)
