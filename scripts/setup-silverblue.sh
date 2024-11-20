#!/usr/bin/env bash

set -euxo pipfail

# Import RPM Fusion
rpm-ostree install \
	"https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
	"https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
# Install Nvidia driver and setup secure boot
rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
# Disable Nouveau
rpm-ostree kargs --append=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1

ms_repo() {
	local repo=$1
	sudo tee "/etc/yum.repos.d/ms-$repo.repo" <<EOF
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

# Import Microsoft repos
google_repo chrome
ms_repo edge
ms_repo vscode
# Install personal packages
curl -fL "https://download.opensuse.org/repositories/home:loichyan/Fedora_$(rpm -E %fedora)/home:loichyan.repo" |
	sudo tee /etc/yum.repos.d/home-loichyan.repo

# Install common packages
rpm-ostree install mygnome mysilverblue

# Enable podman socket
systemctl --user enable --now podman.socket
