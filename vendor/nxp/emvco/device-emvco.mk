NXP_VENDOR_DIR := nxp
PRODUCT_PACKAGES += \
    android.hardware.emvco-V1-ndk \
    android.hardware.emvco-service \
    EMVCoAidlHalComplianceTest \
    EMVCoAidlHalDesfireTest \
    EMVCoModeSwitchApp

BOARD_SEPOLICY_DIRS += vendor/$(NXP_VENDOR_DIR)/emvco/sepolicy
