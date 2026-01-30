#!/usr/bin/env bash

set -euxo pipefail

# Enable tap-to-click
sudo tee /etc/dconf/db/gdm.d/06-tap-to-click <<EOF
[org/gnome/desktop/peripherals/touchpad]
tap-to-click=true
EOF
sudo dconf update

# Load .config/dconf/user.txt
echo 'service-db:keyfile/user' | sudo tee -a /etc/dconf/profile/user

# Use gpg-agent as SSH agent.
# See <https://wiki.archlinux.org/title/GNOME/Keyring#Disabling>.
if has systemctl && has gnome-keyring; then
	systemctl --user mask gcr-ssh-agent.socket gcr-ssh-agent.service
fi
