{
  pkgs,
  inputs,
  lockfile,
}:
let
  inherit (pkgs) lib;
  selfNode = {
    name = "dotfiles";
    value.type = "path";
    value.path = toString inputs.self;
  };
  lockfileJson = lib.importJSON lockfile;
  lockedNodes = builtins.filter ({ name, ... }: builtins.hasAttr name inputs) (
    lib.mapAttrsToList (name: node: {
      name = name;
      value = node.locked;
    }) lockfileJson.nodes
  );
in
rec {
  registry = pkgs.writeText "registry" (
    builtins.toJSON {
      version = 2;
      flakes = builtins.map (
        { name, value }:
        {
          from.type = "indirect";
          from.id = name;
          to = value;
          exact = true;
        }
      ) (lockedNodes ++ [ selfNode ]);
    }
  );
  /**
    Pins all flake inputs to the local registry.
  */
  pin = pkgs.writeShellScriptBin "pin" ''
    cat ${registry} >~/.config/nix/registry.json
  '';
  /**
    Updates the current flake inputs to the same as the global inputs.
  */
  flake-sync-lock =
    let
      overrides = builtins.map (
        { name, value }: "--override-input ${name} ${builtins.flakeRefToString value}"
      ) lockedNodes;
    in
    pkgs.writeShellScriptBin "flake-sync-lock" ''
      nix flake lock ${builtins.concatStringsSep " " overrides}
    '';
}
