#!/bin/bash
set -euxo pipefail
adduser chromium -D
adduser chromium root
adduser chromium tty

config_path=/data/options.json
url="$(jq --raw-output '.url' "$config_path")"

echo "#!/bin/sh" > /usr/local/bin/start
echo "exec chromium-browser --kiosk '$url' --disable-gpu --disable-software-rasterizer --disable-dev-shm-usage" >> /usr/local/bin/start
/usr/bin/dbus-daemon --system
/usr/bin/matchbox-keyboard --daemon
su -c 'startx /usr/local/bin/start' chromium