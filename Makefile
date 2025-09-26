ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:13.0

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = libDeviceSpoofer

libDeviceSpoofer_FILES = src/DeviceManager.m src/entry.m
libDeviceSpoofer_CFLAGS = -fobjc-arc
libDeviceSpoofer_FRAMEWORKS = Foundation IOKit CoreFoundation UIKit
libDeviceSpoofer_PRIVATE_FRAMEWORKS = MobileCoreServices

include $(THEOS_MAKE_PATH)/library.mk
