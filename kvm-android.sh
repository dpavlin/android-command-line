#!/bin/sh -x

# originally based on 
# http://www.android-x86.org/documents/qemuhowto
#qemu-kvm -soundhw es1370 -net nic -net user -cdrom vm.iso

name=froyo
name=android-x86-1.6-r2

boot=emulator/$name.boot.qcow2
sdcard=emulator/$name.sdcard.qcow2

test -f $boot   || qemu-img create $boot   512M && cdrom="-cdrom emulator/$name.iso"
test -f $sdcard || qemu-img create $sdcard 256M

kvm -soundhw ac97 -net nic -net user -hda $boot -hdb $sdcard $cdrom
