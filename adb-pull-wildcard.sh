#!/bin/sh -e

test -z "$1" && echo "usage: $0 /sdcard/DCIM/Camera/*20121111*" && exit 1

ls $1 | tr -d '\r' | xargs -i sh -c 'echo {} ; adb pull {} .'

