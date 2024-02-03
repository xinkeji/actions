TARGET := iphone:clang:latest:13.0
INSTALL_TARGET_PROCESSES = YouTube

ARCHS = arm64


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = uYouButtonFix

uYouButtonFix_FILES = Tweak.x
uYouButtonFix_CFLAGS = -fobjc-arc
uYouButtonFix_LOGOS_DEFAULT_GENERATOR = internal

include $(THEOS_MAKE_PATH)/tweak.mk
