# 🏠 Dotfiles

loichyan's dotfiles.

## ✨ Overview <a id="information"></a>

![showcase](https://loichyan.github.io/dotfiles/assets/showcase.jpg)

- Operating system: [Fedora Silverblue](https://silverblue.fedoraproject.org/)
- Package manager: [Home Manager](https://github.com/nix-community/home-manager)
- Shell: [Fish](https://fishshell.com/)
- Terminal: [tmux](https://github.com/tmux/tmux) +
  [tmux-base16](https://github.com/loichyan/tmux-base16)
- Editor: [Neovim](https://neovim.io/) +
  [Meowim](https://github.com/loichyan/Meowim)
- Font: [Baccano](https://github.com/loichyan/baccano-font)

## 🚀 Installation

### Deploy dotfiles

Check out <https://www.chezmoi.io/> for more advanced usage.

```sh
chezmoi apply
```

### Setup Home Manager

Build the first generation of Home Manager (following
[this guide](https://rycee.gitlab.io/home-manager/index.html#ch-nix-flakes)):

```sh
nix run home-manager/master -- switch
# (Optional) Install nixGL to use graphical apps
nix profile install nix-community/nixGL --impure
```

## ⚖️ License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or
  <http://www.apache.org/licenses/LICENSE-2.0>)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or
  <http://opensource.org/licenses/MIT>)

at your option.
