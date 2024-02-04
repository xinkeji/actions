export TARGET = iphone:clang:latest:14.0
export ARCHS = arm64


ifndef YOUTUBE_VERSION
YOUTUBE_VERSION = 19.04.3
endif
PACKAGE_VERSION = $(YOUTUBE_VERSION)

INSTALL_TARGET_PROCESSES = YouTube
TWEAK_NAME = uYouPlus
DISPLAY_NAME = YouTube
BUNDLE_ID = com.google.ios.youtube

$(TWEAK_NAME)_FILES := $(wildcard Sources/*.xm) $(wildcard Sources/*.x)
$(TWEAK_NAME)_FRAMEWORKS = UIKit Security
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -DTWEAK_VERSION=\"$(PACKAGE_VERSION)\"

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

