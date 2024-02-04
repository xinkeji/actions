TARGET := iphone:clang:latest:13.0
INSTALL_TARGET_PROCESSES = YouTube

ARCHS = arm64

ifndef YOUTUBE_VERSION
YOUTUBE_VERSION = 19.04.3
endif
PACKAGE_VERSION = $(YOUTUBE_VERSION)

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = uYouPlus

$(TWEAK_NAME)_FILES := $(wildcard Sources/*.xm) $(wildcard Sources/*.x)
$(TWEAK_NAME)_FRAMEWORKS = UIKit Security
$(TWEAK_NAME)_CFLAGS = -fobjc-arc


include $(THEOS_MAKE_PATH)/tweak.mk
