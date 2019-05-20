ARG BUILD_FROM=hassioaddons/base:3.1.0
FROM $BUILD_FROM AS build-env
RUN apk add alpine-sdk
RUN adduser builder -D
RUN adduser builder abuild

COPY libfakekey /home/builder/libfakekey
COPY matchbox-keyboard /home/builder/matchbox-keyboard
RUN chown builder:builder -R /home/builder

USER builder
ENV HOME /home/builder
WORKDIR /home/builder

RUN abuild-keygen -a
USER root
RUN cp /home/builder/.abuild/*.rsa.pub /etc/apk/keys/
USER builder
RUN cd /home/builder/libfakekey && abuild -r
USER root
RUN apk add --repository /home/builder/packages/builder libfakekey
USER builder
RUN cd /home/builder/matchbox-keyboard && abuild -r

FROM $BUILD_FROM
ENV LANG C.UTF-8

COPY --from=build-env /etc/apk/keys/ /etc/apk/keys/
COPY --from=build-env /home/builder/packages/builder /var/lib/packages/local
RUN echo /var/lib/packages/local >> /etc/apk/repositories
RUN apk add xorg-server xf86-video-fbdev xf86-input-libinput eudev dbus chromium matchbox-keyboard

RUN echo "#!/bin/bash" > /etc/X11/xinit/xserverrc \
  && echo 'exec /usr/bin/X -s 0 dpms -nocursor -nolisten tcp "$@"' >> /etc/X11/xinit/xserverrc

RUN ln -s /var/lib/dbus/machine-id /etc/machine-id

COPY run.sh /usr/local/bin/chromium-kiosk

CMD ["/usr/local/bin/chromium-kiosk"]

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION
