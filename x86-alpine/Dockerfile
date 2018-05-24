# Couchpotato for x86

FROM alpine:3.7

# Update packages and install software
RUN apk -U update && \
        apk -U upgrade && \
        apk -U add --no-cache dumb-init python py-lxml py-openssl sudo shadow && \
        rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

ADD couchpotato/ /etc/couchpotato/
ADD CouchPotatoServer /CouchPotatoServer

VOLUME ["/data", "/config", "/downloads", "/movies", "/movies-ro"]

RUN addgroup -g 911 -S abc && adduser -S -u 911 -h /data -s /bin/false -G abc abc

EXPOSE 5050

CMD ["dumb-init", "/etc/couchpotato/start.sh"]
