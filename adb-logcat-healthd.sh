#!/bin/sh -xe

adb shell logcat | grep --line-buffered healthd | tee healthd.$( date +%Y-%m-%d )
