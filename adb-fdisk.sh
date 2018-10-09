#!/bin/sh -e

block=mmcblk0

adb shell grep . /sys/block/$block/*p*/start | sed -e 's,/start:, ,' -e 's/[\r\n]$//'  > /dev/shm/$block.start
adb shell grep . /sys/block/$block/*p*/size  | sed -e 's,/size:, ,'  -e 's/[\r\n]$//'  > /dev/shm/$block.size
join /dev/shm/mmcblk0.start /dev/shm/mmcblk0.size | sort -k 2 -n | column -t | tee /dev/shm/$block.part

