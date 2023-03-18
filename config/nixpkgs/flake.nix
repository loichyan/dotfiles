{
  description = "My nixpkgs registry";

  outputs = { ... }: {
    templates = {
      basic = {
        path = ./templates/basic;
        description = "A simple nix project.";
      };
      license = {
        path = ./templates/license;
        description = "MIT OR Apache-2.0 license.";
      };
      rust = {
        path = ./templates/rust;
        description = "A simple rust project.";
      };
    };
  };
}
