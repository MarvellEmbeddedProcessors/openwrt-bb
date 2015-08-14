#
# Copyright (C) 2012-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

LOADADDR:=0x00008000

JFFS2_BLOCKSIZE = 128k

KDIR_TMP:=$(KDIR)/tmp

define Image/Build/DTB
	cp $(KDIR)/zImage$(2) $(KDIR)/zImage$(2)-$(1);
	cat $(DTS_DIR)/$(1).dtb >> $(KDIR)/zImage$(2)-$(1);
	$(call Image/BuildKernel/MkuImage, \
		none, $(LOADADDR), $(LOADADDR), \
		$(KDIR)/zImage$(2)-$(1), $(KDIR)/uImage$(2)-$(1))
	cp $(KDIR)/uImage$(2)-$(1) $(BIN_DIR)/$(IMG_PREFIX)-uImage$(2)-$(1)
endef


define NANDProfile
  define Image/BuildKernel/Profile/$(1)
	$(call Image/Build/DTB,$(2))
    ifneq ($(CONFIG_TARGET_ROOTFS_INITRAMFS),)
	$(call Image/Build/Profile,$(1)/Initramfs)
    endif
  endef

  define Image/Build/Profile/$(1)/BuildSysupgrade
	$(call Image/Build/SysupgradeNAND,$(2),$$(1),$(KDIR)/uImage-$(2))
  endef

  define Image/Build/Profile/$(1)/Initramfs
	$(call Image/Build/DTB,$(2),-initramfs)
	cp $(KDIR)/uImage-initramfs-$(2) $(BIN_DIR)/$(IMG_PREFIX)-$(2)-initramfs
  endef

  define Image/Build/Profile/$(1)/squashfs
	$(call Image/Build/UbinizeImage,$(2),,squashfs, -p $(3) -m $(4) $(if $(5),-s $(5)) $(if $(6),-O $(6)))
	cp $(KDIR)/$$(IMG_PREFIX)-$(2)-squashfs-ubinized.bin $(BIN_DIR)
  endef

  PROFILES_LIST += $(1)
endef


define UBINORProfile
  define Image/BuildKernel/Profile/$(1)
	$(call Image/Build/DTB,$(2))
    ifneq ($(CONFIG_TARGET_ROOTFS_INITRAMFS),)
	$(call Image/Build/Profile,$(1)/Initramfs)
    endif
  endef

  define Image/Build/Profile/$(1)/Initramfs
	$(call Image/Build/DTB,$(2),-initramfs)
  endef

  define Image/Build/Profile/$(1)/squashfs
	$(call Image/Build/UbinizeImage,$(2),,squashfs, -p $(3) -m 1)
  endef

  PROFILES_LIST += $(1)
endef


define NORProfile
  define Image/BuildKernel/Profile/$(1)
	$(call Image/Build/DTB,$(2))
    ifneq ($(CONFIG_TARGET_ROOTFS_INITRAMFS),)
	$(call Image/Build/Profile,$(1)/Initramfs)
    endif
  endef

  define Image/Build/Profile/$(1)/Initramfs
	$(call Image/Build/DTB,$(2),-initramfs)
  endef

  define Image/Build/Profile/$(1)/squashfs
	( \
		dd if=$(KDIR)/uImage-$(2) bs=$(3) conv=sync; \
		dd if=$(KDIR)/root.squashfs bs=$(3) conv=sync; \
	) > $$(BIN_DIR)/$$(IMG_PREFIX)-$(2)-squashfs-firmware.bin
  endef

  PROFILES_LIST += $(1)
endef


define MultiProfile
  define Image/BuildKernel/Profile/$(1)
	$(foreach profile, $(2),
		$(call Image/BuildKernel/Profile/$(profile)))
  endef

  define Image/Build/Profile/$(1)/BuildSysupgrade
	$(foreach profile, $(2),
		$(call Image/Build/Profile/$(profile)/BuildSysupgrade,$$(1)))
  endef

  define Image/Build/Profile/$(1)/Initramfs
	$(foreach profile, $(2),
		$(call Image/Build/Profile/$(profile)/Initramfs))
  endef

  define Image/Build/Profile/$(1)/squashfs
	$(foreach profile, $(2),
		$(call Image/Build/Profile/$(profile)/squashfs))
  endef
endef


define Image/Build/Profile/385_DB_AP/squashfs
	$(call Image/Build/UbinizeImage,armada-385-db-ap,,squashfs, -p 256KiB -m 4096)

	# ubi rootfs
	cp $(KDIR)/$(IMG_PREFIX)-armada-385-db-ap-squashfs-ubinized.bin $(BIN_DIR)/$(IMG_PREFIX)-armada-385-db-ap.ubi

	# mainline firmware image
	( \
		dd if=$(KDIR)/uImage-armada-385-db-ap bs=8M conv=sync; \
		dd if=$(KDIR)/$(IMG_PREFIX)-armada-385-db-ap-squashfs-ubinized.bin \
		bs=4096 conv=sync; \
	) > $(BIN_DIR)/$(IMG_PREFIX)-armada-385-db-ap-squashfs-factory.img
endef

$(eval $(call NANDProfile,385_DB_AP,armada-385-db-ap,256KiB,4096))


define Image/BuildKernel
	$(call Image/BuildKernel/Profile/$(PROFILE))
endef

define Image/Build/squashfs
	# Align the squashfs image size before calling the profiles,
	# otherwise the size would keep growing
	$(call prepare_generic_squashfs,$(KDIR)/root.squashfs)
	$(call Image/Build/Profile/$(PROFILE)/squashfs)
endef

define Image/Build
	$(call Image/Build/$(1))
	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/$(IMG_PREFIX)-root.$(1) bs=128k conv=sync
	$(call Image/Build/Profile/$(PROFILE)/BuildSysupgrade,$(1))
ifneq ($(CONFIG_TARGET_ROOTFS_INITRAMFS),)
	$(call Image/Build/Profile/$(PROFILE)/Initramfs)
endif
endef


$(eval $(call MultiProfile,Default,$(PROFILES_LIST)))
$(eval $(call BuildImage))
