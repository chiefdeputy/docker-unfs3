FROM mitcdh/unfs3
MAINTAINER Nimbix, Inc. <support@nimbix.net>

RUN apk --update add e2fsprogs-extra && rm -rf /var/cache/apk/*

EXPOSE 111/udp 111/tcp 2049/tcp 2049/udp
VOLUME /export

CMD ["docker-entrypoint.sh"]
