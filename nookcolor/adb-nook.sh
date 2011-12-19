#!/bin/sh -x

# http://nookdevs.com/NookColor_USB_ADB

mkdir -p ~/.android && echo 0x2080 >> ~/.android/adb_usb.ini && adb kill-server && adb devices

