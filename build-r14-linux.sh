# Android/ARM, armeabi-v7a (ARMv7 VFP), Android 4.1+ (JB)
make clean
$(info "build r14 linux ...")

NDK=F:/android-ndk-r14b-linux
NDKBIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin
NDKABI=21
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-arm"
# NDKCC=$NDKBIN/armv7a-linux-androideabi$NDKAPI-clang
NDKCROSS=$NDKBIN/arm-linux-androideabi-
NDKARCH="-march=armv7-a -mfloat-abi=softfp -Wl,--fix-cortex-a8"
make \
     HOST_CC="gcc -m32" \
     CROSS=$NDKCROSS \
     TARGET_FLAGS="$NDKF $NDKARCH"

     # TARGET_AR="$NDKBIN/llvm-ar rcus" \
     # TARGET_STRIP=$NDKBIN/llvm-strip \
     # STATIC_CC=$NDKCC \
     # DYNAMIC_CC="$NDKCC -fPIC" \
     # TARGET_LD=$NDKCC \
     # TARGET_SYS=Linux \
     