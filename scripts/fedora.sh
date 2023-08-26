#!/usr/bin/env bash

# Import RPM Fusion
source /etc/os-release &&
  rpm-ostree install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$VERSION_ID.noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$VERSION_ID.noarch.rpm
# Install Nvidia driver and setup secure boot.
rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
# Disable Nouveau
rpm-ostree kargs --append=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1

ms_repo() {
  local repo=$1
  sudo tee "/etc/yum.repos.d/ms_$repo.repo" <<EOF
[ms-$repo]
name=ms-$repo
baseurl=https://packages.microsoft.com/yumrepos/$repo
skip_if_unavailable=True
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
}

# Import Microsoft repos.
ms_repo edge
ms_repo vscode
# Personal packages
source /etc/os-release &&
  curl -fL "https://download.opensuse.org/repositories/home:loichyan/Fedora_$VERSION_ID/home:loichyan.repo" |
  sudo tee /etc/yum.repos.d/home_loichyan.repo

# Install common packages.
rpm-ostree install \
  fish wezterm wl-clipboard \
  v2raya xray \
  code podman-compose \
  mygnome cascadia-code-fonts symbols-nerd-fonts

# Install Nix.
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Activate Home Manager
nix run home-manager/master -- switch

# Enable podman socket.
systemctl --user enable --now podman.socket

# Enable tap-to-click
sudo tee /etc/dconf/db/gdm.d/06-tap-to-click <<<"\
[org/gnome/desktop/peripherals/touchpad]
tap-to-click=true"
sudo dconf update

# Load .config/dconf/user.txt
echo 'service-db:keyfile/user' | sudo tee -a /etc/dconf/profile/user
