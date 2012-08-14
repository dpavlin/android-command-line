#!/bin/sh -x

adb shell setprop ctl.stop media
adb shell setprop ctl.stop zygote
adb shell setprop ctl.stop surfaceflinger
adb shell setprop ctl.stop drm
adb shell
