{
  description = "My nixpkgs registry";

  outputs = { ... }: {
    templates = {
      basic = {
        path = ./templates/basic;
        description = "A simple nix project";
      };
      repo = {
        path = ./templates/repo;
        description = "Starter of a repository";
      };
      rust = {
        path = ./templates/rust;
        description = "A simple rust project";
      };
    };
  };
}
