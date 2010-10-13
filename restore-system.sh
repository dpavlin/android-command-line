#!/bin/sh -x

remount_path() {
	adb shell df $1 | grep /dev/ | tr -d '\r' | \
	awk '{ print "mount -o remount,'$2' "$1" "$6 }' | xargs -i adb shell {}
}

find system -type f -print | while read FILE ; do
	dir=`dirname $FILE`
	name=`basename $FILE`
	echo "# $FILE -> $dir $name"
	remount_path $dir rw
	dev=`adb shell df system/etc/init.d/ | grep /dev/`
	adb push $FILE $dir
	remount_path $dir ro
done
