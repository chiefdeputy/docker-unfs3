FROM alpine:3.17
MAINTAINER Nimbix, Inc. <support@nimbix.net>

RUN apk --update add \
    unfs3 \
    rpcbind \
    tzdata \
 && rm -rf /var/cache/apk/*

COPY exports /etc/exports
COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 111/udp 111/tcp 2049/tcp 2049/udp
VOLUME /export

CMD ["docker-entrypoint.sh"]
