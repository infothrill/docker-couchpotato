# Couchpotato for raspberry pi

FROM resin/rpi-raspbian:stretch

# Update packages and install software
RUN apt-get update && \
        apt-get upgrade && \
        apt-get -y install --no-install-recommends dumb-init python python-lxml python-openssl && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD couchpotato/ /etc/couchpotato/
ADD CouchPotatoServer /CouchPotatoServer

VOLUME ["/data", "/config", "/downloads", "/movies", "/movies-ro"]

RUN groupmod -g 1000 users \
    && useradd -u 911 -U -d /data -s /bin/false abc \
    && usermod -G users abc

EXPOSE 5050

CMD ["dumb-init", "/etc/couchpotato/start.sh"]
