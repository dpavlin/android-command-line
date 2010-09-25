#!/bin/sh -x

# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=560056

sudo sysctl -w net.ipv6.bindv6only=0

# java -Djava.net.preferIPv4Stack=true

