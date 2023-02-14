# Android/ARM, armeabi-v7a (ARMv7 VFP), Android 4.1+ (JB)
make clean
NDK=F:/android-ndk-r18b-linux
NDKBIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin
NDKAPI=21
# NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-arm"
NDKCROSS=$NDKBIN/arm-linux-androideabi-
NDKCC=$NDKBIN/armv7a-linux-androideabi$NDKAPI-clang
# NDKARCH="-march=armv7-a -mfloat-abi=softfp -Wl,--fix-cortex-a8"
make \
     HOST_CC="gcc -m32" \
     CROSS=$NDKCROSS \
     TARGET_AR="$NDKBIN/llvm-ar rcus" \
     TARGET_STRIP=$NDKBIN/llvm-strip \
     STATIC_CC=$NDKCC \
     # DYNAMIC_CC="$NDKCC -fPIC" \
     # TARGET_LD=$NDKCC \
     # TARGET_SYS=Linux \
     