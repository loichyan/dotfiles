# 🏠 Dotfiles

loichyan's dotfiles.

## 📸 Showcase

![wezterm](assets/wezterm.png)

## ✨ Overview

- Mainly run on [Fedora Silverblue](https://silverblue.fedoraproject.org/)
- Depoly using [chezmoi](https://github.com/twpayne/chezmoi)
- Manage packages using
  [Home Manager](https://github.com/nix-community/home-manager)
- Customize shell using [fish](https://fishshell.com/)
- Customize NeoVim using [DeltaVim](https://github.com/loichyan/DeltaVim)
- Terminal & mux using [wezterm](https://wezfurlong.org/wezterm)

## 🚀 Installation

### Deploy dotfiles

Check [the website](https://www.chezmoi.io/) for more advanced usage.

```sh
chezmoi apply
```

### Setup Home Manager

Build the first generation of Home Manager (following
[this guide](https://rycee.gitlab.io/home-manager/index.html#ch-nix-flakes)):

```sh
nix run home-manager/master -- switch
./result/activate
```

### Import OBS repository

Check [the repo](https://github.com/loichyan/packages) for more details.

```sh
source /etc/os-release &&
  dnf config-manager --add-repo https://download.opensuse.org/repositories/home:loichyan/Fedora_$VERSION_ID/home:loichyan.repo
# Or download manually
source /etc/os-release &&
  curl -fL "https://download.opensuse.org/repositories/home:loichyan/Fedora_$VERSION_ID/home:loichyan.repo" |
  sudo tee /etc/yum.repos.d/home_loichyan.repo
```

## ⚖️ License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or
  <http://www.apache.org/licenses/LICENSE-2.0>)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or
  <http://opensource.org/licenses/MIT>)

at your option.
