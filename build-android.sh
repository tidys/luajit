#!/bin/sh
# install dep
sudo apt-get install gcc automake autoconf libtool make gcc-multilib

# download ndk
ndk_dir=$(pwd)/android-ndk-r14b
if [ ! -d "${ndk_dir}" ]; then
    echo "not exists ndk"
    echo "ndk downloading ..."
    wget https://dl.google.com/android/repository/android-ndk-r14b-linux-x86_64.zip
    echo "unzip ndk"
    unzip android-ndk-r14b-linux-x86_64.zip -d ./
fi
echo "ndk_dir:${ndk_dir}"

script=build-r14-linux.sh
chmod +x ./${script}
./${script}