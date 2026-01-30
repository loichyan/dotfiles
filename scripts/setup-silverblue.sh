#!/usr/bin/env bash

set -euxo pipefail

# Import RPM Fusion
rpm-ostree install \
	"https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
	"https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

# Install Nvidia driver and setup secure boot
rpm-ostree install xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
# Disable Nouveau see <https://docs.fedoraproject.org/en-US/fedora-silverblue/troubleshooting/#_using_nvidia_drivers>
rpm-ostree kargs --append=rd.driver.blacklist=nouveau,nova-core --append=modprobe.blacklist=nouveau,nova-core --append=nvidia-drm.modeset=1 --append=initcall_blacklist=simpledrm_platform_driver_init

# # Import VS Code's repository
# cat <<-INI | sudo tee /etc/yum.repos.d/vscode.repo
# 	[vscode]
# 	name=vscode
# 	baseurl=https://packages.microsoft.com/yumrepos/vscode
# 	gpgkey=https://packages.microsoft.com/keys/microsoft.asc
# 	enabled=1
# 	gpgcheck=1
# INI

# # Import my personal packages
# cat <<-INI | sudo tee /etc/yum.repos.d/obs-loichyan.repo
# 	[obs-loichyan]
# 	name=obs:loichyan (Fedora_\$releasever)
# 	baseurl=https://download.opensuse.org/repositories/home:/loichyan/Fedora_\$releasever/
# 	gpgkey=https://download.opensuse.org/repositories/home:/loichyan/Fedora_\$releasever/repodata/repomd.xml.key
# 	enabled=1
# 	gpgcheck=1
# INI

cat <<-INI | sudo tee /etc/yum.repos.d/obs-loichyan.repo
	[nvidia-container-toolkit]
	name=nvidia-container-toolkit
	baseurl=https://nvidia.github.io/libnvidia-container/stable/rpm/\$basearch
	repo_gpgcheck=1
	gpgcheck=0
	enabled=1
	gpgkey=https://nvidia.github.io/libnvidia-container/gpgkey
	sslverify=1
	sslcacert=/etc/pki/tls/certs/ca-bundle.crt

	[nvidia-container-toolkit-experimental]
	name=nvidia-container-toolkit-experimental
	baseurl=https://nvidia.github.io/libnvidia-container/experimental/rpm/\$basearch
	repo_gpgcheck=1
	gpgcheck=0
	enabled=0
	gpgkey=https://nvidia.github.io/libnvidia-container/gpgkey
	sslverify=1
	sslcacert=/etc/pki/tls/certs/ca-bundle.crt
INI

# Install common packages
rpm-ostree install mygnome mysilverblue

# Enable podman socket
systemctl --user enable --now podman.socket
