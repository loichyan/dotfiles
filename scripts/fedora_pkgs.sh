#!/usr/bin/env bash

# Import RPM Fusion
rpm-ostree install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
#  Install Nvidia driver and setup secure boot.
rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda
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

# Install common packages.
rpm-ostree install podman-compose tmux zsh \
  gnome-tweaks kitty yaru-theme \
  fira-code-fonts cascadia-code-fonts langpacks-zh_CN ibus-rime \
  ffmpeg wl-clipboard xclip \
  wezterm symbols-nerd-font \
  code microsoft-edge-stable

# Install Nix.
sh <(curl https://mirrors.tuna.tsinghua.edu.cn/nix/latest/install) --no-daemon --no-modify-profile

# Enable podman socket.
systemctl --user enable --now podman.socket
