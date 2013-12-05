#
# Store the local path
#

COCOS_LOCAL_PATH := $(call my-dir)


#
# Build cocos2d-x library
#

$(call import-add-path,../../cocos2dx/platform/third_party/android/prebuilt)

include ../../cocos2dx/Android.mk

COCOS2DX_BUILT_MODULE := $(LOCAL_BUILT_MODULE)


#
# Build CocosDenshion library
#

include ../../CocosDenshion/android/Android.mk

CCDENSHION_BUILT_MODULE := $(LOCAL_BUILT_MODULE)


#
# Make output directories, then copy all built libraries
#

COCOS_LIB := ../../lib
COCOS_LIB_NDK := $(COCOS_LIB)/Android.Ndk
COCOS_THIRD_PREBUILT := ../../cocos2dx/platform/third_party/android/prebuilt

COCOS_ARCH_ABI := $(TARGET_ARCH_ABI)

# $(call third-copy,lib-name)
define third-copy
  $(call host-cp,$(COCOS_THIRD_PREBUILT)/$1/libs/$@/$1.a,$(COCOS_LIB_NDK)/$@/$1.a)
endef

all: $(COCOS_ARCH_ABI)

$(COCOS_ARCH_ABI): $(COCOS2DX_BUILT_MODULE) $(CCDENSHION_BUILT_MODULE)
	$(call host-mkdir,$(COCOS_LIB))
	$(call host-mkdir,$(COCOS_LIB_NDK))
	$(call host-mkdir,$(COCOS_LIB_NDK)/$@)
	$(call host-cp,obj/local/$@/libcocos2d.a,$(COCOS_LIB_NDK)/$@/libcocos2d.a)
	$(call host-cp,obj/local/$@/libcocosdenshion.a,$(COCOS_LIB_NDK)/$@/libcocosdenshion.a)
	$(call host-cp,obj/local/$@/libcpufeatures.a,$(COCOS_LIB_NDK)/$@/libcpufeatures.a)
	$(call third-copy,libjpeg)
	$(call third-copy,libpng)
	$(call third-copy,libtiff)
	$(call third-copy,libwebp)


#
# Clean the output directories
#

clean: $(COCOS_ARCH_ABI)-clean

$(COCOS_ARCH_ABI)-clean:
	$(call host-rm,$(COCOS_LIB)/Android.Ndk/$(subst -clean,,$@)/*.a)


#
# Appendix
# : Validate all necessary NDK undocumented macros are defined 
#
 
ifndef LOCAL_BUILT_MODULE
$(error LOCAL_BUILT_MODULE not defined)
endif
 
ifndef host-mkdir
$(error host-mkdir not defined)
endif
 
ifndef host-cp
$(error host-cp not defined)
endif
 
ifndef host-rm
$(error host-rm not defined)
endif
