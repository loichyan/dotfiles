#!/usr/bin/env bash

set -euxo pipefail

if [[ -f /etc/default/grub ]]; then
	sudo cp /etc/default/grub /etc/default/grub-backup
fi
# Remove duplicate Fedora entries
# c.f. https://discussion.fedoraproject.org/t/duplicated-grub-entries-on-silverblue-kinoite/33882/5
cat <<-CONF | sudo tee /etc/default/grub
	GRUB_TIMEOUT=5
	GRUB_DISTRIBUTOR="\$(sed 's, release .*\$,,g' /etc/system-release)"
	GRUB_DEFAULT=saved
	GRUB_DISABLE_SUBMENU=true
	GRUB_TERMINAL_OUTPUT=gfxterm
	GRUB_CMDLINE_LINUX="rhgb quiet"
	GRUB_DISABLE_RECOVERY=true
	GRUB_ENABLE_BLSCFG=true
CONF

tempdir="$(mktemp -d)"
trap 'rm $tempdir' EXIT
git clone https://github.com/vinceliuice/grub2-themes "$tempdir"
cd "$tempdir"
sudo ./install.sh -b -t stylish
