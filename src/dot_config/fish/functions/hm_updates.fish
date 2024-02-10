function hm_upadtes -d "Show updated packages of Home Manager generations"
    nix profile diff-closures --profile ~/.local/state/nix/profiles/home-manager
end
