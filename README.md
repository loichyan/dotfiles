# 🏠 Dotfiles

My dotfiles.

## 📸 Showcase

### Neovim

![neovim](assets/neovim.png)

### Tmux

![tmux](assets/tmux.png)

## ✨ Overview

- Mainly run on [Fedora Silverblue](https://silverblue.fedoraproject.org/)
- Depoly using [Chezmoi](https://www.chezmoi.io/)
- Manage packages using
  [Home Manager](https://github.com/nix-community/home-manager)
- Customize zsh using [Zimfw](https://zimfw.sh/)
- Customize neovim using [MiNV](https://github.com/loichyan/minv)

## 🚀 Installation

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

## 📝 Todo

- [x] Beautify Tumx.
- [ ] Switch to [dbot](https://github.com/loichyan/dbot)

## ⚖️ License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or
  <http://www.apache.org/licenses/LICENSE-2.0>)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or
  <http://opensource.org/licenses/MIT>)

at your option.
