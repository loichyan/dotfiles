# Dotfiles

My dotfiles managed by [Chezmoi](https://www.chezmoi.io/) and
[Home Manager](https://github.com/nix-community/home-manager).

## Installation

### Deploy dotfiles

```sh
chezmoi apply
```

### Setup Home Manager

Build the first generation of Home Manager (following
[this guide](https://rycee.gitlab.io/home-manager/index.html#ch-nix-flakes)):

```sh
cd ~/.config/nixpkgs
nix build ".#homeConfigurations.${YOUR_USER}.activationPackage"
./result/activate
```

## TODO

- [x] Beautify Tumx.
