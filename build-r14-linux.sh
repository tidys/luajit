#!/bin/sh
out_dir=android
out_dir_abs=$(pwd)/${out_dir}
if [ -d "${out_dir_abs}" ]; then
     echo "dir remove: ${out_dir_abs}"
     rm -rf ${out_dir_abs}
fi

if [ ! -d "${out_dir_abs}" ]; then
     echo "dir create: ${out_dir_abs}"
     mkdir -p ${out_dir_abs}
fi

echo "build with r14-linux ..."
NDK=$(pwd)/android-ndk-r14b
NDKBIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin
NDKABI=21
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-arm"
NDKCROSS=$NDKBIN/arm-linux-androideabi-

buildArch()  {
     ARCH=${1}
     echo "build arch ${ARCH}"
     NDKARCH="-march=${ARCH} -mfloat-abi=softfp -Wl,--fix-cortex-a8"
     make clean
     make -j 6
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
     if [ $? -ne 0 ]; then
          return 1
     fi
     arch_dir=${out_dir_abs}/${ARCH}
     if [ ! -d ${arch_dir} ]; then 
          mkdir -p ${arch_dir}
     fi

     if [ -e "src/libluajit.a" ]; then 
          mv "src/libluajit.a" ${arch_dir}
          return 0
     fi
     return 2
}

# armeabi-v7a x86 armeabi arm64-v8a
for arch in armv7-a armv8-a
do
     buildArch ${arch}
     if [ $? -ne 0 ]; then
          echo "build arch failed: ${arch}"
          break
     else
          echo "build arch success: ${arch}"
     fi
done

tar_file=android.tar
rm -f ./${tar_file}
tar cvf ${tar_file} ./android







