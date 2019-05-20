docker run --rm --privileged -v \
    ~/.docker:/root/.docker homeassistant/amd64-builder \
    --all -t chromium_kiosk -r https://github.com/dflemstr/hassio-addons

