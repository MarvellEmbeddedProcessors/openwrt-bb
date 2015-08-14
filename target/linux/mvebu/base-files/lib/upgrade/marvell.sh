#
# Copyright (C) 2015 OpenWrt.org
#

platform_do_upgrade_marvell_385_db_ap() {
	ubi detach /dev/mtd2
	CI_UBIPART="rootfs"
	nand_upgrade_tar "$1"
}
