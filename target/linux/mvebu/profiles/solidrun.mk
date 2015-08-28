#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/388_SOLIDRUN_CLEARFOG_A1
  NAME:=SolidRun ClearFog a1 board
  PACKAGES:= \
	kmod-usb3 kmod-usb2 kmod-usb-storage \
	kmod-of-i2c kmod-i2c-core kmod-i2c-mv64xxx \
	kmod-ata-core kmod-ata-marvell-sata \
	kmod-thermal-armada
endef

define Profile/388_SOLIDRUN_CLEARFOG_A1/Description
 Package set compatible with the SolidRun ClearFog a1 board
endef

$(eval $(call Profile,388_SOLIDRUN_CLEARFOG_A1))
