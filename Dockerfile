FROM ubuntu:jammy

LABEL org.opencontainers.image.authors="dev@ixsystems.com"

RUN apt-get update && \
    apt-get install -y ffmpeg imagemagick poppler-utils ghostscript dcraw exiftool locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG=en_US.utf8

ARG REPO_BASE=https://packages.iconik.io/deb/ubuntu

COPY ./install-iconik.sh /tmp/install-iconik.sh
RUN /tmp/install-iconik.sh
RUN \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm /tmp/install-iconik.sh

VOLUME /var/iconik/iconik_storage_gateway/data

ENTRYPOINT /opt/iconik/iconik_storage_gateway/iconik_storage_gateway \
    --iconik-url=${ICONIK_URL:-https://app-lb.iconik.io/} \
    --auth-token=${AUTH_TOKEN} \
    --app-id=${APP_ID} \
    --storage-id=${STORAGE_ID}
