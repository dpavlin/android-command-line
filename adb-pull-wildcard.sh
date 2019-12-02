#!/bin/sh -e

test -z "$1" && echo "usage: $0 /sdcard/DCIM/Camera/*20121111*" && exit 1

adb shell ls "$1" | tr -d '\r' | xargs -i sh -c 'echo "{}" ; adb pull "{}" .'

