#!/usr/bin/env bash

set -euxo pipefail

# Import RPM Fusion
rpm-ostree install \
	"https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
	"https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

# Install Nvidia driver and setup secure boot
rpm-ostree install xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
# Disable Nouveau
rpm-ostree kargs --append=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1

# Import my personal packages
cat <<-INI | sudo tee /etc/yum.repos.d/home_loichyan.repo
	[home_loichyan]
	name=home:loichyan (Fedora_\$releasever)
	type=rpm-md
	baseurl=https://download.opensuse.org/repositories/home:/loichyan/Fedora_\$releasever/
	gpgcheck=1
	gpgkey=https://download.opensuse.org/repositories/home:/loichyan/Fedora_\$releasever/repodata/repomd.xml.key
	enabled=1
INI

# Install common packages
rpm-ostree install mygnome mysilverblue

# Enable podman socket
systemctl --user enable --now podman.socket
