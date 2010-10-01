#!/bin/sh -x

sdcard=/sdcard/clockworkmod/

adb shell ls -1 -d $sdcard/backup/* | sed "s!$sdcard/*!!" | tr -d '\r' > /tmp/backup.android
ls -1 -d backup/* > /tmp/backup.disk
diff -uw /tmp/backup.android /tmp/backup.disk | grep -- '^-backup' | sed 's/^-//' | \
xargs -i sh -xc "mkdir {} && adb pull $sdcard/{} {}"
