# Dotfiles

My dotfiles managed by
[Home Manager](https://github.com/nix-community/home-manager).

## Installation

Build the first generation of Home Manager (following
[this guide](https://rycee.gitlab.io/home-manager/index.html#ch-nix-flakes)):

```sh
cd ~/.config/nixpkgs
nix build ".#homeConfigurations.${YOUR_USER}.activationPackage"
./result/activate
```

## TODO

- [ ] Beautify Tumx.
