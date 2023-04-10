#!/usr/bin/env bash

# Import RPM Fusion
rpm-ostree install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
#  Install Nvidia driver and setup secure boot.
rpm-ostree install akmod-nvidia
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
# Disable Nouveau
rpm-ostree kargs --append=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1

ms_repo() {
  local repo=$1
  echo "\
[ms_${repo}]
name=ms_${repo}
baseurl=https://packages.microsoft.com/yumrepos/${repo}
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc\
" | sudo tee "/etc/yum.repos.d/ms_${repo}.repo"
}

# Import Microsoft repos.
ms_repo vscode
ms_repo edge

# Install common packages.
rpm-ostree install podman-compose tmux zsh \
  gnome-tweaks kitty yaru-theme \
  fira-code-fonts cascadia-code-fonts langpacks-zh_CN ibus-rime \
  wl-clipboard xclip \
  code microsoft-edge-stable

# Install Nix.
sh <(curl https://mirrors.tuna.tsinghua.edu.cn/nix/latest/install) --no-daemon --no-modify-profile

# Enable podman socket.
systemctl --user enable --now podman.socket
