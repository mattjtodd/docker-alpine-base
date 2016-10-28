FROM alpine:3.4

MAINTAINER Matt Todd

LABEL distro="alpine"

ARG DUMB_INIT_VERSION=1.2.0

ENV DUMB_INIT_URL=https://github.com/Yelp/dumb-init/releases/download/v$DUMB_INIT_VERSION

RUN set -ex \
\
# upgrade
  && apk update \
  && apk upgrade \
\  
# su-exec
  && apk add su-exec \
\
# dumb-init
  && apk add -t build-reources curl \
  && curl --progress-bar -OL ${DUMB_INIT_URL}/dumb-init_${DUMB_INIT_VERSION}_amd64 \
  && curl --progress-bar -L ${DUMB_INIT_URL}/sha256sums | sed -n 2p | sha256sum -c \
  && mv dumb-init_${DUMB_INIT_VERSION}_amd64 /usr/local/bin/dumb-init \
  && chmod +x /usr/local/bin/dumb-init \
  && apk del build-reources \
  && rm -rf /var/cache/apk/*
