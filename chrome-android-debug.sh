#!/bin/sh -x

# http://code.google.com/chrome/mobile/docs/debugging.html

adb forward tcp:9222 localabstract:chrome_devtools_remote
echo http://localhost:9222
