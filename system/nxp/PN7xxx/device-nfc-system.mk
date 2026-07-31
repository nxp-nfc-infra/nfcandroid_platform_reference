#####
##### NXP NFC System Configuration
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

# Hardware permission features
PRODUCT_COPY_FILES += \
frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.nfc.hce.xml \
frameworks/native/data/etc/android.software.secure_lock_screen.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.secure_lock_screen.xml \
frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.nfc.xml

# NFC system config
ifneq ($(NXP_NFC_HW),pn7160)
PRODUCT_COPY_FILES += \
system/$(NXP_VENDOR_DIR)/PN7xxx/hw/$(NXP_NFC_HW)/libnfc-nci.conf:$(TARGET_COPY_OUT_PRODUCT)/etc/libnfc-nci.conf
endif

ifeq ($(NXP_NFC_HW),pn7220_i2cs)
PRODUCT_COPY_FILES += \
system/$(NXP_VENDOR_DIR)/PN7xxx/hw/$(NXP_NFC_HW)/libnfc-nci.conf:$(TARGET_COPY_OUT_PRODUCT)/etc/libnfc-nci.conf
endif

ifeq ($(NXP_NFC_HW),pn7221_i2cs)
PRODUCT_COPY_FILES += \
system/$(NXP_VENDOR_DIR)/PN7xxx/hw/$(NXP_NFC_HW)/libnfc-nci.conf:$(TARGET_COPY_OUT_PRODUCT)/etc/libnfc-nci.conf
endif

# Remove AOSP NFC service
PRODUCT_PACKAGES -= \
com.android.nfcservices

# System NFC related apps
PRODUCT_PACKAGES += \
Tag \
com.nxp.nfcreaders \
NXPDTA \
NfcTdaTestApp \
JrcpProxyPallas \
SOFTPOS_DTE

# Transition from ashmem to memfd
PRODUCT_SYSTEM_PROPERTIES += sys.use_memfd=true