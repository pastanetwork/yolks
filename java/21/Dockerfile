FROM        --platform=$TARGETOS/$TARGETARCH eclipse-temurin:21-jdk-alpine

LABEL       author="Michael Parker" maintainer="parker@pterodactyl.io"

LABEL       org.opencontainers.image.source="https://github.com/pterodactyl/yolks"
LABEL       org.opencontainers.image.licenses=MIT

RUN         apk update && apk add --no-cache \
                curl \
                lsof \
                ca-certificates \
                openssl \
                git \
                tar \
                sqlite \
                fontconfig \
                tzdata \
                iproute2 \
                freetype \
                tini \
                zip \
                unzip

## Setup user and working directory
RUN         adduser -D -h /home/container -s /bin/sh container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL SIGINT

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT    ["/sbin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]
