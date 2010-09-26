#!/bin/sh

image=emulator/android-x86-1.6-r2.boot.qcow2

if mount | grep /tmp/qemu ; then
	echo "umount"
	sudo umount /tmp/qemu
	sudo nbd-client -d /dev/nbd0
	exit 1
fi



echo "mount $image"

qemu-nbd emulator/android-x86-1.6-r2.boot.qcow2 &
sudo nbd-client localhost 1024 /dev/nbd0
mkdir /tmp/qemu
echo "wait for partitions"
while [ ! -e /dev/nbd0p1 ] ; do
	echo -n .
	sleep 1
done
sudo mount /dev/nbd0p1 /tmp/qemu

df -h /tmp/qemu
