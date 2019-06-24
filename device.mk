# Copyright 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Device path
DEVICE_PATH := device/sony/kugo/rootdir

DEVICE_PACKAGE_OVERLAYS += \
    device/sony/kugo/overlay

# declare brcmfmac as the wifi driver
WIFI_DRIVER_BUILT := brcmfmac

# Device Specific Permissions
PRODUCT_COPY_FILES := \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml

# Sensors Configuration
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/vendor/etc/sensors/sensor_def_qcomdev.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/sensor_def_qcomdev.conf

# Thermal Configuration
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/vendor/etc/thermanager.xml:$(TARGET_COPY_OUT_VENDOR)/etc/thermanager.xml

# Camera Configuration
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/vendor/etc/camera/camera_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/camera_config.xml \
    $(DEVICE_PATH)/vendor/etc/camera/imx241_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx241_chromatix.xml \
    $(DEVICE_PATH)/vendor/etc/camera/imx300_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx300_chromatix.xml

# Audio configuration
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/vendor/etc/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml

# Audio calibration
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/vendor/etc/acdbdata/Bluetooth_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Bluetooth_cal.acdb \
    $(DEVICE_PATH)/vendor/etc/acdbdata/General_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/General_cal.acdb \
    $(DEVICE_PATH)/vendor/etc/acdbdata/Global_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Global_cal.acdb \
    $(DEVICE_PATH)/vendor/etc/acdbdata/Handset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Handset_cal.acdb \
    $(DEVICE_PATH)/vendor/etc/acdbdata/Hdmi_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Hdmi_cal.acdb \
    $(DEVICE_PATH)/vendor/etc/acdbdata/Headset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Headset_cal.acdb \
    $(DEVICE_PATH)/vendor/etc/acdbdata/Speaker_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Speaker_cal.acdb

# Focus calibration
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/vendor/etc/tof_focus_calibration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/tof_focus_calibration.xml

# NFC Configuration
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/vendor/etc/libnfc-nxp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp.conf

# BT FW patch
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/vendor/firmware/BCM4345C0.hcd:$(TARGET_COPY_OUT_VENDOR)/firmware/BCM4345C0.hcd

# WIFI FW patch
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/vendor/firmware/bcmdhd.cal:$(TARGET_COPY_OUT_VENDOR)/firmware/bcmdhd.cal
ifeq ($(WIFI_DRIVER_BUILT),brcmfmac)
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/vendor/firmware/bcmdhd.cal:$(TARGET_COPY_OUT_VENDOR)/firmware/brcm/brcmfmac43455-sdio.txt
endif

# Device Init
PRODUCT_PACKAGES += \
    fstab.kugo \
    init.recovery.kugo \
    init.kugo

# Telephony Packages (AOSP)
PRODUCT_PACKAGES += \
    InCallUI \
    Stk

# SAR
PRODUCT_PACKAGES += \
    TransPowerSensors

# Camera Augmented Sensing Helper
PRODUCT_PACKAGES += \
   libpolyreg \
   cashsvr \
   libcashctl

PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREBUILT_DPI := xhdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

PRODUCT_PROPERTY_OVERRIDES := \
    ro.sf.lcd_density=320 \
    ro.usb.pid_suffix=1E8

# Inherit from those products. Most specific first.
$(call inherit-product, device/sony/loire/platform.mk)

# copy wlan firmware
$(call inherit-product-if-exists, vendor/broadcom/wlan/bcmdhd/firmware/bcm43455/device-bcm-vendor.mk)

# copy NFC firmware
$(call inherit-product-if-exists, vendor/nxp/nxp-vendor.mk)

# include board vendor blobs
$(call inherit-product-if-exists, vendor/sony/loire-common/loire-partial.mk)
