{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ra-flake.url = "github:loichyan/ra-flake";
  };

  outputs = { nixpkgs, flake-utils, ... } @ inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = with inputs; [
            inputs.fenix.overlays.default
            # inputs.ra-flake.overlays.default
          ];
        };
        inherit (pkgs) fenix;
        # inherit (pkgs) ra-flake;
        inherit (pkgs.lib) importTOML;

        # Rust toolchain
        rustChannel = {
          channel = (importTOML ./rust-toolchain).toolchain.channel;
          sha256 = "sha256-PjvuouwTsYfNKW5Vi5Ye7y+lL7SsWGBxCtBOOm2z14c=";
        };
        rustToolchain = fenix.toolchainOf rustChannel;
        # Additional targets
        # rustWasmToolChain = fenix.targets.wasm32-unknown-unknown.toolchainOf rustChannel;

        # For development
        rust-dev = fenix.combine (with rustToolchain; [
          defaultToolchain
          rust-src
          rust-analyzer
          # rustWasmToolChain.rust-std
        ]);

        # Earlier Rust toolchains doesn't provide rust-analyzer
        # rust-analyzer = ra-flake.make {
        #   version.rust = rustChannel;
        #   sha256 = "";
        # };

        # For building packages
        rust-minimal = rustToolchain.minimalToolchain;
        rustPlatform = pkgs.makeRustPlatform {
          cargo = rust-minimal;
          rustc = rust-minimal;
        };
      in
      {
        packages.default = rustPlatform.buildRustPackage {
          pname = "CRATE";
          version = "0.0.0";
          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;
        };
        devShells.default = with pkgs; mkShell {
          nativeBuildInputs = [
            rust-dev
            # rust-analyzer
          ];
        };
      }
    );
}
