{
  description = "My nixpkgs flake";

  outputs =
    { ... }:
    {
      templates = {
        basic = {
          path = ./templates/basic;
          description = "Nix project starter";
        };
        justfile = {
          path = ./templates/justfile;
          description = "Justfile starter";
        };
        python = {
          path = ./templates/python;
          description = "Python project starter";
        };
        repo = {
          path = ./templates/repo;
          description = "Repository starter";
        };
        rust = {
          path = ./templates/rust;
          description = "Rust library starter";
        };
        rust-bin = {
          path = ./templates/rust-bin;
          description = "Rust binary starter";
        };
      };
    };
}
