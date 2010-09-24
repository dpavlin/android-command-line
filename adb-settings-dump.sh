#!/bin/sh -x

adb shell sqlite3 /data/data/com.android.providers.settings/databases/settings.db .dump

