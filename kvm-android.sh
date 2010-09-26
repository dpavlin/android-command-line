#!/bin/sh -x

# originally based on 
# http://www.android-x86.org/documents/qemuhowto
#qemu-kvm -soundhw es1370 -net nic -net user -cdrom vm.iso

#name=android-x86-1.6-r2
size=300M

name=froyo
size=600M

boot=emulator/$name.boot.qcow2
sdcard=emulator/$name.sdcard.qcow2

test -f $boot   || qemu-img create $boot   $size && cdrom="-cdrom emulator/$name.iso"
test -f $sdcard || qemu-img create $sdcard 256M

kvm -redir tcp:5555::5555 -soundhw ac97 -m 256 -net nic -net user -hda $boot -hdb $sdcard $cdrom
