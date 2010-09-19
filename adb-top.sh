#!/bin/sh -x
adb shell top | grep -v ' 0% S '
