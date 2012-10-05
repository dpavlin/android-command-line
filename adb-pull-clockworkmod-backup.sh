#!/bin/sh -x

sdcard=/sdcard/clockworkmod/

adb shell find $sdcard/backup/ -mindepth 1 -maxdepth 1 | sed "s!$sdcard/*!!" | tr -d '\r' > /tmp/backup.android
test -d backup || mkdir backup
find backup/ -mindepth 1 -maxdepth 1 -type d | sed 's!backup/!!' > /tmp/backup.disk
diff -uw /tmp/backup.android /tmp/backup.disk | grep -- '^-backup' | sed 's/^-//' | \
xargs -i sh -xc "mkdir {} && adb pull $sdcard/{} {}"
