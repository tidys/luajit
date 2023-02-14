ndk=F:/android-ndk-r14b-windows
ndk_ver=$ndk_ver/toolchains/arm-linux-androideabi-4.9
ndkp=$ndk_ver/prebuilt/windows-x86_64/bin/arm-linux-androideabi
make HOST_CC="gcc -m32" CROSS=