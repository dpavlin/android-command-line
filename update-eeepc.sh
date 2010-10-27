#!/bin/sh -x

# build with: m -j8 iso_img BOARD_USES_I915= BOARD_USES_I915C=true

dir=`date +%Y-%m-%d`
dir=eeepc
a=192.168.1.32:5555

test -d $dir || mkdir $dir

rsync --progress -v android:/srv/android-x86/out/target/product/$dir/{kernel,initrd.img,ramdisk.img,system.sfs} $dir
adb connect $a
adb -s $a mkdir /sdcard/android-froyo
adb -s $a push $dir /sdcard/android-froyo
