#!/bin/sh -e

block=mmcblk0

adb shell grep . /sys/block/$block/*p*/start | sed -e 's,/start:, ,' -e 's/[\r\n]$//'  > /dev/shm/$block.start
adb shell grep . /sys/block/$block/*p*/size  | sed -e 's,/size:, ,'  -e 's/[\r\n]$//'  > /dev/shm/$block.size
adb shell grep PARTNAME /sys/block/$block/*p*/uevent  | sed -e 's,/uevent:PARTNAME=, ,'  -e 's/[\r\n]$//'  > /dev/shm/$block.name
join /dev/shm/$block.start /dev/shm/$block.size > /dev/shm/$block.2
join /dev/shm/$block.2     /dev/shm/$block.name | sort -k 2 -n | column -t | tee /dev/shm/$block.part

