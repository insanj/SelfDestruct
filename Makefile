THEOS_PACKAGE_DIR_NAME = debs
TARGET = :clang
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

TWEAK_NAME = SelfDestruct
SelfDestruct_FILES = SelfDestruct.xm
SelfDestruct_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
# SUBPROJECTS = SDListener
# include $(THEOS_MAKE_PATH)/aggregate.mk

internal-after-install::
	install.exec "killall -9 backboardd"
