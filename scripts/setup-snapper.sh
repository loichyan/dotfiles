#!/usr/bin/env bash

set -euxo pipefail

# Setup auto backup
sudo btrfs subvolmue create "$HOME"
sudo snapper -c "$USER" create-config "$HOME"
sudo systemctl enable snapper-cleanup.timer snapper-timeline.timer

cat <<-INI | sudo tee "/etc/snapper/configs/$USER"
	# subvolume to snapshot
	SUBVOLUME="$HOME"

	# filesystem type
	FSTYPE="btrfs"


	# btrfs qgroup for space aware cleanup algorithms
	QGROUP=""


	# fraction or absolute size of the filesystems space the snapshots may use
	SPACE_LIMIT="0.5"

	# fraction or absolute size of the filesystems space that should be free
	FREE_LIMIT="0.2"


	# users and groups allowed to work with config
	ALLOW_USERS=""
	ALLOW_GROUPS=""

	# sync users and groups from ALLOW_USERS and ALLOW_GROUPS to .snapshots
	# directory
	SYNC_ACL="no"


	# start comparing pre- and post-snapshot in background after creating
	# post-snapshot
	BACKGROUND_COMPARISON="yes"


	# run daily number cleanup
	NUMBER_CLEANUP="yes"

	# limit for number cleanup
	NUMBER_MIN_AGE="1800"
	NUMBER_LIMIT="25"
	NUMBER_LIMIT_IMPORTANT="5"


	# create hourly snapshots
	TIMELINE_CREATE="yes"

	# cleanup hourly snapshots after some time
	TIMELINE_CLEANUP="yes"

	# limits for timeline cleanup
	TIMELINE_MIN_AGE="1800"
	TIMELINE_LIMIT_HOURLY="5"
	TIMELINE_LIMIT_DAILY="5"
	TIMELINE_LIMIT_WEEKLY="5"
	TIMELINE_LIMIT_MONTHLY="5"
	TIMELINE_LIMIT_YEARLY="0"


	# cleanup empty pre-post-pairs
	EMPTY_PRE_POST_CLEANUP="yes"

	# limits for empty pre-post-pair cleanup
	EMPTY_PRE_POST_MIN_AGE="1800"
INI
