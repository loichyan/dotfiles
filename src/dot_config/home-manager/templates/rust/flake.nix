{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #ra-flake.url = "github:loichyan/ra-flake";
  };

  outputs =
    { nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            inputs.fenix.overlays.default
            #inputs.ra-flake.overlays.default
          ];
        };
        inherit (pkgs)
          lib
          mkShell
          fenix
          #ra-flake
          ;

        # Rust toolchain
        crate = (lib.importTOML ./Cargo.toml).package;
        rustChannel = {
          channel = crate.rust-version;
          sha256 = "";
        };
        rustToolchain = fenix.toolchainOf rustChannel;
        # Additional targets
        #rustWasmToolChain = fenix.targets.wasm32-unknown-unknown.toolchainOf rustChannel;

        # For development
        rust-dev = fenix.combine (
          with rustToolchain;
          [
            defaultToolchain
            rust-src
            #rustWasmToolChain.rust-std
          ]
        );
        rust-analyzer = rustToolchain.rust-analyzer;
        # rust-analyzer is not available before Rust 1.64
        #rust-analyzer = ra-flake.make {
        #  version.rust = crate.rust-version;
        #  sha256 = "";
        #};

        # For building packages
        rust-minimal = rustToolchain.minimalToolchain;
        rustPlatform = pkgs.makeRustPlatform {
          cargo = rust-minimal;
          rustc = rust-minimal;
        };
      in
      {
        packages.default = rustPlatform.buildRustPackage {
          pname = crate.name;
          version = crate.version;
          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;
          meta = {
            description = crate.description;
            homepage = crate.repository;
            license = with lib.licenses; [
              mit
              asl20
            ];
          };
        };

        devShells.default = mkShell {
          packages = [ rust-dev ];
        };
        devShells.with-rust-analyzer = mkShell {
          packages = [
            rust-dev
            rust-analyzer
          ];
        };
      }
    );
}
