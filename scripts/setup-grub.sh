#!/usr/bin/env bash

set -euxo pipefail

tempdir="$(mktemp -d)"
trap 'rm $tempdir' EXIT
git clone https://github.com/vinceliuice/grub2-themes "$tempdir"
cd "$tempdir"
sudo ./install.sh -b -t stylish
# Remove duplicate Fedora entries
# c.f. https://discussion.fedoraproject.org/t/duplicated-grub-entries-on-silverblue-kinoite/33882/5
if [ -d /sys/firmware/efi ]; then
	sudo grub2-switch-to-blscfg
	sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
else
	sudo touch /boot/grub2/.grub2-blscfg-supported
	sudo grub2-mkconfig -o /boot/grub2/grub.cfg
fi
