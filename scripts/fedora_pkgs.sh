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

google_repo() {
  local repo=$1
  sudo tee "/etc/yum.repos.d/google-$repo.repo" <<EOF
[google-$repo]
name=google-$repo
baseurl=https://dl.google.com/linux/$repo/rpm/stable/\$basearch
skip_if_unavailable=True
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF
}

# Import Microsoft repos.
google_repo chrome
ms_repo edge
ms_repo vscode
# Personal packages
source /etc/os-release &&
  curl -fL "https://download.opensuse.org/repositories/home:loichyan/Fedora_$VERSION_ID/home:loichyan.repo" |
  sudo tee /etc/yum.repos.d/home_loichyan.repo

# Disable auto-update
gsettings get org.gnome.software download-updates

# Install common packages.
rpm-ostree install \
  fish wezterm \
  gnome-tweaks yaru-theme ibus-rime \
  gnome-shell-extension-pop-shell pop-launcher qalculate \
  xray v2raya \
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

# Load .config/dconf/user.txt
echo 'service-db:keyfile/user' | sudo tee -a /etc/dconf/profile/user
