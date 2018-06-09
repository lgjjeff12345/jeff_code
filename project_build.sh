#! /bin/bash

set -e

current_dir=`pwd`


build_vboot()
{
   pushd .

   cd $current_dir/src/boot/vboot
   make

   popd
}

build_uboot()
{
   pushd .

   echo "Started to build uboot"
   cd $current_dir/src/boot/u-boot
   make mini2440_config
   make
   echo "Build uboot done"

   popd
}
build_boot()
{
    build_vboot
    build_uboot
}

build_linux()
{
    pushd .

    echo "Started to build linux"
    cd $current_dir/src/linux/linux-2.6.32.2
    make zImage

    popd

}

export PATH=$PATH:$current_dir/toolchain/opt/FriendlyARM/toolschain/4.4.3/bin
export PATH=$PATH:$current_dir/toolchain/opt/FriendlyARM/toolschain/4.4.3/lib
export LD_LIBRARY_PATH="$current_dir/toolchain/opt/FriendlyARM/toolschain/4.4.3/lib"
echo $PATH

if [ $1 = "" ];then
   $1=full
fi

if [ $1 = boot ];then
    echo "Build boot"
    build_boot
elif [ $1 = linux ];then
    echo "Build linux"
    build_linux
elif [ $1 = rootfs ];then
    echo "Build rootfs"
elif [ $1 = full ];then
     echo "Build full"
     build_boot
     build_linux
else
    echo "Unsupport option $1"
fi
