#!/bin/sh -xe

# http://wiki.cyanogenmod.org/w/Doc:_dropbear

pub=$HOME/.ssh/id_rsa.pub
cat $pub

adb push $pub /sdcard/authorized_keys
cat << EOF | adb shell
mkdir /data/dropbear
chmod 755 /data/dropbear
mkdir /data/dropbear/.ssh
chmod 700 /data/dropbear/.ssh
mv /sdcard/authorized_keys /data/dropbear/.ssh/
chown root: /data/dropbear/.ssh/authorized_keys
chmod 600 /data/dropbear/.ssh/authorized_keys
dropbearkey -t rsa -f /data/dropbear/dropbear_rsa_host_key
dropbearkey -t dss -f /data/dropbear/dropbear_dss_host_key
exit
EOF
