#!/bin/sh -x

sdcard=/sdcard/DCIM/Camera/
to=/data/DCIM/Camera/

adb shell find $sdcard -mindepth 1 -maxdepth 1 | sed "s!$sdcard/*!!" | tr -d '\r' | sort > /tmp/dcim.android
test -d $to || mkdir $to
find $to -mindepth 1 -maxdepth 1 | sed "s!$to!!" | sort > /tmp/dcim.disk
diff -uw /tmp/dcim.android /tmp/dcim.disk | grep -- "^-" | sed 's/^-//' | \
xargs -i sh -xc "adb pull $sdcard/{} $to/{}"
