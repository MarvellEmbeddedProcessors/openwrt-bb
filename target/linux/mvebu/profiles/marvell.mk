#
# Copyright (C) 2013-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/385_DB_AP
  NAME:=Marvell Armada 385 DB AP (DB-88F6820-AP)
  PACKAGES:= \
	kmod-usb3 kmod-usb2 kmod-usb-storage \
	kmod-of-i2c kmod-i2c-core kmod-i2c-mv64xxx \
	kmod-ata-core kmod-ata-marvell-sata \
	kmod-thermal-armada
endef

define Profile/385_DB_AP/Description
 Package set compatible with the Armada 385 access point development board (DB-88F6820-AP).
endef

385_DB_AP_UBIFS_OPTS:="-m 4096 -e 248KiB -c 4096"

$(eval $(call Profile,385_DB_AP))
