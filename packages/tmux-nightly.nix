{ tmux, fetchFromGitHub }:
let
  rev = "33cfe8b8096fbfd2c13998b8baa5c8e43177d5e0";
in
tmux.overrideAttrs (
  self: super: {
    version = builtins.substring 0 7 rev;
    src = fetchFromGitHub {
      inherit rev;
      owner = "tmux";
      repo = "tmux";
      hash = "sha256-tNwUHeqj3Yrwmp9FLdXB0AMX7PNM2JD5SyH07dTadHk=";
    };
  }
)
