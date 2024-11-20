{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ inputs.fenix.overlays.default ];
        };
        inherit (pkgs) lib mkShell fenix;

        toolchainFile = (lib.importTOML ./rust-toolchain.toml);
        cargoManifest = (lib.importTOML ./Cargo.toml);
        crate = cargoManifest.package;

        # Rust toolchain for development
        rustChannel = {
          channel = toolchainFile.toolchain.channel;
          sha256 = "";
        };
        rustToolchain = fenix.toolchainOf rustChannel;
        rust-dev = fenix.combine (
          with rustToolchain;
          [
            defaultToolchain
            rust-src
          ]
          # Add additional targets
          ++ (builtins.map (target: fenix.targets."${target}".toolchainOf rustChannel) [
            "wasm32-unknown-unknown"
          ])
        );

        # Rust toolchain of MSRV
        rust-msrv =
          (fenix.toolchainOf {
            channel = crate.rust-version;
            sha256 = "";
          }).minimalToolchain;

        # TODO: use nixpkgs's builtin platform
        # Rust toolchain to build packages
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
            rustToolchain.rust-analyzer
          ];
        };
        devShells.msrv = mkShell {
          packages = [ rust-msrv ];
        };
      }
    );
}
