TARGET := iphone:clang:16.2:14.0
INSTALL_TARGET_PROCESSES = YouTube

ARCHS = arm64 arm64e

THEOS_DEVICE_IP = 10.12.3.128

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = YTNoHoverCards

YTNoHoverCards_FILES = Tweak.x
YTNoHoverCards_CFLAGS = -fobjc-arc
YTNoHoverCards_LOGOS_DEFAULT_GENERATOR = internal

include $(THEOS_MAKE_PATH)/tweak.mk
