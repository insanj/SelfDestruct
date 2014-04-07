TARGET = :clang
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

TWEAK_NAME = SDListener
SDListener_FILES = SDListener.xm
SDListener_LDFLAGS = -lactivator -Ltheos/lib

include $(THEOS_MAKE_PATH)/tweak.mk
