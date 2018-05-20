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

build_boot()
{
    build_vboot
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
elif [ $1 = rootfs ];then
    echo "Build rootfs"
elif [ $1 = full ];then
     echo "Build full"
     build_boot
else
    echo "Unsupport option $1"
fi
