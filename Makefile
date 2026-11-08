TARGET := iphone:clang:latest:15.0
ARCHS := arm64
INSTALL_TARGET_PROCESSES := Litmatch

include $(THEOS)/makefiles/common.mk

TWEAK_NAME := LitmatchAdControl
LitmatchAdControl_FILES := Tweak.xm
LitmatchAdControl_CFLAGS := -fobjc-arc
LitmatchAdControl_FRAMEWORKS := Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
