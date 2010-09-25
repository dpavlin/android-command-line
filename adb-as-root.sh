#!/bin/sh -x

# restart adb as root to fix
# error: insufficient permissions for device

adb=`which adb`
$adb kill-server
sudo $adb devices
