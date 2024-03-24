{ pkgs, ... }:
with builtins;
let
  # Stolen from: https://github.com/NixOS/nixpkgs/blob/44d0940/pkgs/tools/misc/zellij/default.nix
  inherit (pkgs)
    lib fetchFromGitHub rustPlatform stdenv installShellFiles perl pkg-config
    libiconv openssl DiskArbitration Foundation mandown;

  rev = "5fb75ab6d13bd6e22790224a8a0541a8ac73be60";
  zellij-nightly = rustPlatform.buildRustPackage {
    pname = "zellij-nightly";
    version = substring 0 7 rev;

    src = fetchFromGitHub {
      owner = "zellij-org";
      repo = "zellij";
      rev = rev;
      hash = "sha256-D5FhxZ584iKBofj/91cjKXn44qDit986TXzdhtkTGf0=";
    };

    cargoHash = "sha256-qX0Adrbu1smJ0/3U9tX494m9Z2X+CmMRPxFAjj24tgc=";

    nativeBuildInputs = [ mandown installShellFiles perl pkg-config ];

    buildInputs = [ openssl ]
      ++ lib.optionals stdenv.isDarwin [ libiconv DiskArbitration Foundation ];

    preCheck = ''
      HOME=$TMPDIR
    '';

    postInstall = ''
      mandown docs/MANPAGE.md > zellij.1
      installManPage zellij.1

      installShellCompletion --cmd $pname \
        --bash <($out/bin/zellij setup --generate-completion bash) \
        --fish <($out/bin/zellij setup --generate-completion fish) \
        --zsh <($out/bin/zellij setup --generate-completion zsh)
    '';

    meta = with lib; {
      description = "A terminal workspace with batteries included";
      homepage = "https://zellij.dev/";
      license = with licenses; [ mit ];
      mainProgram = "zellij";
    };
  };
in { home.packages = [ zellij-nightly ]; }
