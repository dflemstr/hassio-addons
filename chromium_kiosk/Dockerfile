ARG BUILD_FROM=hassioaddons/base:3.1.0
FROM $BUILD_FROM
ENV LANG C.UTF-8

RUN apk add xorg-server xf86-video-fbdev xf86-input-evdev xf86-input-libinput eudev dbus chromium
RUN echo "#!/bin/bash" > /etc/X11/xinit/xserverrc \
  && echo 'exec /usr/bin/X -s 0 dpms -nolisten tcp "$@"' >> /etc/X11/xinit/xserverrc
RUN ln -s /var/lib/dbus/machine-id /etc/machine-id

COPY run.sh /usr/local/bin/chromium-kiosk
CMD ["/usr/local/bin/chromium-kiosk"]

