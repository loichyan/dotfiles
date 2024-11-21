#!/usr/bin/env bash

set -euxo pipefail

cat <<-CONF | sudo tee /etc/sysctl.d/99-custom.conf
	# QUIC buffer
	net.core.rmem_max = 2500000
	net.core.wmem_max = 2500000
	# TUN proxy
	net.ipv4.ip_forward = 1
CONF
sudo sysctl --system
