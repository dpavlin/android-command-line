#!/bin/sh -x

start() {
	adb shell setprop ctl.start $1
}

start zygote
start media
start surfaceflinger
start drm

adb logcat
