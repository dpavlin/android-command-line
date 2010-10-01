#!/bin/sh -x

dir=`date +%Y-%m-%d`
dir=cyanogen

rsync --progress -v android:/srv/cyanogen/out/target/product/dream_sapphire/{boot.img,recovery.img,system.img,android-info.txt} $dir
adb reboot-bootloader
sudo ./fastboot devices
sudo sh -c "ANDROID_PRODUCT_OUT=$dir/ ./fastboot flashall"
