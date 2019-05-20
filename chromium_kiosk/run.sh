#!/bin/bash
set -euxo pipefail
adduser chromium -D
adduser chromium root
adduser chromium tty

config_path=/data/options.json
url="$(jq --raw-output '.url' "$config_path")"

echo "/usr/bin/chromium-browser --kiosk '$url' --disable-gpu --disable-software-rasterizer --disable-dev-shm-usage" >> /home/chromium/.xinitrc
/usr/bin/dbus-daemon --system
su -c startx chromium
