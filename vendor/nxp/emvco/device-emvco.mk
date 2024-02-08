NXP_VENDOR_DIR := nxp
NXP_NFC_HW := $(TARGET_NXP_NFC_HW)
ifeq ($(strip $(TARGET_NXP_NFC_HW)),)
    NXP_NFC_HW := pn7220
endif

PRODUCT_PACKAGES += \
    vendor.nxp.emvco-V1-ndk \
    vendor.nxp.emvco-service \
    EMVCoAidlHalComplianceTest \
    EMVCoAidlHalDesfireTest \
    EMVCoModeSwitchApp \
    EMVCoAidlHalTransacTest

BOARD_SEPOLICY_DIRS += vendor/$(NXP_VENDOR_DIR)/emvco/sepolicy
ifeq ($(NXP_NFC_HW),pn7220)
PRODUCT_COPY_FILES += \
    vendor/$(NXP_VENDOR_DIR)/emvco/hw/$(NXP_NFC_HW)/libemvco-nxp.conf:vendor/etc/libemvco-nxp.conf
endif