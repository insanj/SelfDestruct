THEOS_PACKAGE_DIR_NAME = debs
TARGET = :clang
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

TWEAK_NAME = SelfDestruct
SelfDestruct_FILES = SelfDestruct.xm
SelfDestruct_LDFLAGS = -lactivator -Ltheos/lib
SelfDestruct_PRIVATE_FRAMEWORKS = SpringBoardServices

include $(THEOS_MAKE_PATH)/tweak.mk

internal-after-install::
	install.exec "killall -9 backboardd"
