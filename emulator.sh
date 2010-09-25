#!/bin/sh -x

emulator -debug-all -verbose -logcat main $*
