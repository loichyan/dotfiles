#!/usr/bin/env bash

# Import RPM Fusion
source /etc/os-release &&
  rpm-ostree install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$VERSION_ID.noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$VERSION_ID.noarch.rpm
#  Install Nvidia driver and setup secure boot.
rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
# Disable Nouveau
rpm-ostree kargs --append=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1

ms_repo() {
  local repo=$1
  sudo tee "/etc/yum.repos.d/_ms-${repo}.repo" <<<"\
[ms-${repo}]
name=ms-${repo}
baseurl=https://packages.microsoft.com/yumrepos/${repo}
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc"
}

# Import Microsoft repos.
ms_repo edge
ms_repo vscode
# Personal packages
source /etc/os-release &&
  curl "https://copr.fedorainfracloud.org/coprs/loichyan/packages/repo/$ID-$VERSION_ID/dnf.repo" |
  sudo tee /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:loichyan:packages.repo

# Disable auto-update
gsettings get org.gnome.software download-updates

# Install common packages.
rpm-ostree install \
  fish wezterm \
  gnome-tweaks yaru-theme ibus-rime \
  cascadia-code-fonts sarasa-gothic-fonts symbols-nerd-fonts \
  podman-compose wl-clipboard xclip \
  ffmepg mozilla-openh264 \
  code

# Install Nix.
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Enable podman socket.
systemctl --user enable --now podman.socket

# Enable tap-to-click
sudo tee /etc/dconf/db/gdm.d/06-tap-to-click <<<"\
[org/gnome/desktop/peripherals/touchpad]
tap-to-click=true"
sudo dconf update
