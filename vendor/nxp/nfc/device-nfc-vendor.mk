#####
##### NXP NFC Vendor Configuration
#####

NXP_NFC_HOST := $(TARGET_PRODUCT)
ifndef TARGET_NXP_NFC_HW
NXP_NFC_HW := pn7220_i2cs
else
NXP_NFC_HW := $(TARGET_NXP_NFC_HW)
endif

NXP_NFC_PLATFORM := pn54x
NXP_VENDOR_DIR := nxp
NXP_I2CM_S := $(TARGET_NXP_I2C_M_S)

ifeq ($(strip $(TARGET_NXP_I2C_M_S)),)
NXP_I2CM_S := FALSE
endif

# Vendor NFC configs
PRODUCT_COPY_FILES += \
vendor/$(NXP_VENDOR_DIR)/nfc/hw/$(NXP_NFC_HW)/libnfc-nxp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp.conf \
vendor/$(NXP_VENDOR_DIR)/nfc/hw/init.module.nfc.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.module.nfc.rc

ifneq ($(NXP_NFC_HW),pn7160)
PRODUCT_COPY_FILES += \
vendor/$(NXP_VENDOR_DIR)/nfc/hw/$(NXP_NFC_HW)/libnfc-nxp-eeprom.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp-eeprom.conf
endif

ifeq ($(NXP_NFC_HW),pn7220_i2cs)
PRODUCT_COPY_FILES += \
vendor/$(NXP_VENDOR_DIR)/nfc/hw/$(NXP_NFC_HW)/libnfc-nxp-rfExt.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp-rfExt.conf
endif

ifeq ($(NXP_NFC_HW),pn7221_i2cs)
PRODUCT_COPY_FILES += \
vendor/$(NXP_VENDOR_DIR)/nfc/hw/$(NXP_NFC_HW)/libnfc-nxp-rfExt.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp-rfExt.conf
endif

# NFC Init
PRODUCT_COPY_FILES += \
vendor/$(NXP_VENDOR_DIR)/nfc/hw/init.$(NXP_NFC_PLATFORM).nfc.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.$(NXP_NFC_HOST).nfc.rc

# Vendor HAL / services
PRODUCT_PACKAGES += \
android.hardware.nfc2-service.nxp \
libnfc_reader_vendor_extn_vnd \
VtsAidlHalNfcTargetTest

ifeq ($(ENABLE_TREBLE), true)
PRODUCT_PACKAGES += \
vendor.nxp.nxpnfc@1.0-impl \
vendor.nxp.nxpnfc@1.0-service
endif

# Hardware specific packages
ifeq ($(NXP_NFC_HW),pn7220_i2cms)
PRODUCT_PACKAGES += \
SmcuSwitchV2_0
endif

ifeq ($(NXP_NFC_HW),pn7221_i2cms)
PRODUCT_PACKAGES += \
SmcuSwitchV2_0
endif

ifeq ($(NXP_NFC_HW),pn7160)
PRODUCT_PACKAGES += \
SelfTestHalAidlNfc
endif

# I2C configuration
ifeq ($(strip $(NXP_I2CM_S)),TRUE)
I2CM_S_ENABLED = 1
else
I2CM_S_ENABLED = 0
endif

PRODUCT_PROPERTY_OVERRIDES += \
ro.hardware.nfc_nci=$(NXP_NFC_PLATFORM) \
persist.vendor.nxp.i2cms.enabled=$(I2CM_S_ENABLED)

# Vendor sepolicy
BOARD_SEPOLICY_DIRS += \
vendor/$(NXP_VENDOR_DIR)/nfc/sepolicy \
vendor/$(NXP_VENDOR_DIR)/nfc/sepolicy/nfc