ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:13.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DeviceSpoofer

DeviceSpoofer_FILES = src/Tweak.x src/DeviceManager.m src/entry.m
DeviceSpoofer_CFLAGS = -fobjc-arc
DeviceSpoofer_FRAMEWORKS = Foundation IOKit CoreFoundation
DeviceSpoofer_PRIVATE_FRAMEWORKS = MobileCoreServices

include $(THEOS_MAKE_PATH)/tweak.mk