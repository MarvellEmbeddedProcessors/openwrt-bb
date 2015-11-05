#
# Copyright (C) 2012-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

ARCH:=arm
BOARD:=mvebu
BOARDNAME:=Marvell Armada 37x/38x/39x/XP
FEATURES:=targz usb pci pcie gpio nand squashfs ubifs
CPU_TYPE:=cortex-a9
CPU_SUBTYPE:=vfpv3

LINUX_VERSION:=3.10.70
# use the one below for 3.14
# LINUX_VERSION:=3.14.33

include $(INCLUDE_DIR)/target.mk

KERNELNAME:="zImage dtbs"

DEFAULT_PACKAGES += uboot-envtools

$(eval $(call BuildTarget))
