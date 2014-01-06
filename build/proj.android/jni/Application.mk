APP_PLATFORM := android-14
APP_ABI := x86 armeabi armeabi-v7a
APP_STL := gnustl_static

APP_CFLAGS := -fexceptions
APP_CPPFLAGS := -std=c++11 -frtti

ifeq ($(NDEBUG),1)

# Release
APP_OPTIM := release
COCOS_CONFIG := Release

else

# Debug
APP_OPTIM := debug
COCOS_CONFIG := Debug
APP_CFLAGS += -g -DCOCOS2D_DEBUG=1

endif

NDK_APP_OUT := obj/$(COCOS_CONFIG)
NDK_TOOLCHAIN_VERSION := 4.8
