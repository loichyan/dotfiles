#  Install Nvidia driver and setup secure boot.
rpm-ostree install akmod-nvidia
rpm-ostree kargs --append=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1
sudo mokutil --import /etc/pki/akmods/certs/public_key.der

# Import repos for Edge and Code.
ms_repo() {
  local name=$1
  local url=$2
  echo "\
  [$name]
  name=$name
  baseurl=$url
  enabled=1
  gpgcheck=1
  gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee "/etc/yum.repos.d/$name.repo"
}
ms_repo vscode https://packages.microsoft.com/yumrepos/vscode
ms_repo msedge https://packages.microsoft.com/yumrepos/edge

# Install common packages.
rpm-ostree install distrobox zsh tmux podman-compose neovim \
  gnome-tweaks gnome-shell-extension-user-theme yaru-theme \
  gnome-console gnome-console-nautilus \
  code edge

# Enable podman socket.
systemctl --user enable --now podman.socket

# Install node packages.
pnpm add -g commitizen
