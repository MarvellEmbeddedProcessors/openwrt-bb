#
# Copyright (C) 2015 OpenWrt.org
#

. /lib/mvebu.sh

RAMFS_COPY_DATA=/lib/mvebu.sh

platform_check_image() {
	local board=$(mvebu_board_name)
	local magic_long="$(get_magic_long "$1")"

	[ "$#" -gt 1 ] && return 1

	case "$board" in
	armada-385-db-ap)
		[ "$magic_long" != "73797375" ] && {
			echo "Invalid image type."
			return 1
		}
		return 0;
		;;
	*)
		;;
	esac

	echo "Sysupgrade is not yet supported on $board."
	return 1
}

platform_do_upgrade() {
	local board=$(mvebu_board_name)

	case "$board" in
	armada-385-db-ap)
		platform_do_upgrade_marvell_385_db_ap "$ARGV"
		;;
	*)
		;;
	esac
}
