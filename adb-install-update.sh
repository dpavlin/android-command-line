#!/bin/sh -x

#  The recovery tool communicates with the main system through /cache files.
#   /cache/recovery/command - INPUT - command line for tool, one arg per line
#   /cache/recovery/log - OUTPUT - combined log file from recovery run(s)
#   /cache/recovery/intent - OUTPUT - intent that was passed in
#
# The arguments which may be supplied in the recovery.command file:
#   --send_intent=anystring - write the text out to recovery.intent
#   --update_package=root:path - verify install an OTA package file
#   --wipe_data - erase user data (and cache), then reboot
#   --wipe_cache - wipe cache (but not user data), then reboot
#
# After completing, we remove /cache/recovery/command and reboot.

if [ ! -e "$1" ] ; then
	echo "Usage: $0 update.zip"
	exit 1
fi

adb shell "rm /sdcard/update.zip"

adb push $1 /sdcard/update.zip || exit 1

adb remount
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/update.zip' >> /cache/recovery/command"
adb shell "echo '--wipe_cache' >> /cache/recovery/command"
adb shell "echo 'reboot' >> /cache/recovery/command"
adb shell "reboot recovery"
