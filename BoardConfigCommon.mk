#
# Copyright (C) 2016 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Platform Architecture Configuration
TARGET_BOARD_PLATFORM := baytrail
TARGET_BOOTLOADER_BOARD_NAME := $(TARGET_BOARD_PLATFORM)

ifeq ($(BOARD_USE_64BIT_USERSPACE),true)
  TARGET_ARCH := x86_64
  TARGET_ARCH_VARIANT := silvermont
  TARGET_CPU_ABI := x86_64
  TARGET_2ND_ARCH := x86
  TARGET_2ND_ARCH_VARIANT := silvermont
  TARGET_2ND_CPU_ABI := x86
  TARGET_CPU_ABI_LIST_64_BIT := x86_64 arm64-v8a
  TARGET_CPU_ABI_LIST_32_BIT := x86 armeabi-v7a armeabi
  TARGET_CPU_ABI_LIST := x86_64 x86 armeabi-v7a armeabi arm64-v8a
  ADDITIONAL_BUILD_PROPERTIES += ro.dalvik.vm.isa.arm64=x86_64 ro.enable.native.bridge.exec64=1
else
  TARGET_ARCH := x86
  TARGET_ARCH_VARIANT := silvermont
  TARGET_CPU_ABI := x86
  TARGET_CPU_ABI_LIST_32_BIT := x86 armeabi-v7a armeabi
  TARGET_CPU_ABI_LIST := x86 armeabi-v7a armeabi
endif
TARGET_CPU_SMP := true
ADDITIONAL_BUILD_PROPERTIES += ro.dalvik.vm.isa.arm=x86 ro.enable.native.bridge.exec=1
ADDITIONAL_DEFAULT_PROPERTIES += ro.dalvik.vm.native.bridge=libhoudini.so

# Binder API version
TARGET_USES_64_BIT_BINDER := $(if $(filter x86_64,$(TARGET_ARCH) $(TARGET_KERNEL_ARCH)),true)
# Nativebridge / Houdini: enable ARM codegen for x86
BUILD_ARM_FOR_X86 := true

# Use dlmalloc
MALLOC_IMPL := dlmalloc
# customize the malloced address to be 16-byte aligned
BOARD_MALLOC_ALIGNMENT := 16

# File System / Partition Configuration
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false

# Set a minimal size for system partition of 1.5 GB
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1610612736
BOARD_FLASH_BLOCK_SIZE := 512

# Audio
BOARD_USES_ALSA_AUDIO := false
BOARD_USES_TINY_ALSA_AUDIO := true
BOARD_USES_AUDIO_HAL_XML := true

# Enable ALSA utils for eng and userdebug builds
ifneq (,$(filter $(TARGET_BUILD_VARIANT),eng userdebug))
BUILD_WITH_ALSA_UTILS := true
endif

BOARD_USES_GENERIC_AUDIO := false

# Bluetooth
BOARD_HAVE_BLUETOOTH := true

# Charger
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGER_SHOW_PERCENTAGE := true
BOARD_CHARGER_DISABLE_INIT_BLANK := true

# Hardware Accelerated Graphics
ENABLE_GEN_GRAPHICS := true

# Select ufo gen7 libs
UFO_ENABLE_GEN := gen7
# Defines Intel library for GPU accelerated Renderscript:
OVERRIDE_RS_DRIVER := libRSDriver_intel7.so
USE_OPENGL_RENDERER := true
USE_INTEL_UFO_DRIVER := true
USE_INTEL_UFO_OPENCL := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
INTEL_VA := true
BOARD_GRAPHIC_IS_GEN := true

# System's VSYNC phase offsets in nanoseconds
VSYNC_EVENT_PHASE_OFFSET_NS := 7500000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 5000000

# Allow HWC to perform a final CSC on virtual displays
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true

# Intel Media
BUILD_WITH_FULL_STAGEFRIGHT := true
INTEL_STAGEFRIGHT := true

# Settings for the Media SDK library and plug-ins:
# - USE_MEDIASDK: use Media SDK support or not
USE_MEDIASDK := true

# Settings for MPEG4-ASP:
# - USE_SW_MPEG4: use software MPEG4 decoder including ASP support
# - USE_INTEL_IPP: use IPP acceleration in decoders
# - BOARD_USES_WRS_OMXIL_CORE: load WRS omx-il core
# - BOARD_USES_MRST_OMX: load omx-component for MPEG4-ASP
USE_SW_MPEG4 := true
USE_INTEL_IPP := true
BOARD_USES_WRS_OMXIL_CORE := true
BOARD_USES_MRST_OMX := true
INTEL_VA := true

# Media: DRM Protected Video
BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 1
USE_INTEL_SECURE_AVC := true

# Security
BUILD_WITH_CHAABI_SUPPORT := true
BUILD_WITH_WATCHDOG_DAEMON_SUPPORT := true

# Enable dex-preoptimization to speed up the first boot sequence
ifneq ($(TARGET_BUILD_VARIANT),eng)
WITH_DEXPREOPT := true
endif
DONT_DEXPREOPT_PREBUILTS := true

# Enable Minikin text layout engine (will be the default soon)
USE_MINIKIN := true

# Skip some proccess to speed up build
BOARD_SKIP_ANDROID_DOC_BUILD := true
BUILD_EMULATOR := false

# WiFi
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION      := VER_0_8_X

# SELinux Policy : baytrail
-include device/intel/board/platform/baytrail/sepolicy.mk
