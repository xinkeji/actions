TARGET := iphone:clang:latest:12.0
INSTALL_TARGET_PROCESSES = YouTube

ARCHS = arm64 arm64e


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = YTNoHoverCards

YTNoHoverCards_FILES = Tweak.x
YTNoHoverCards_CFLAGS = -fobjc-arc
YTNoHoverCards_LOGOS_DEFAULT_GENERATOR = internal

include $(THEOS_MAKE_PATH)/tweak.mk
