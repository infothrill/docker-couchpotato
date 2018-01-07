# Couchpotato for raspberry pi

FROM resin/rpi-raspbian:jessie

# Update packages and install software
RUN apt-get update \
    && apt-get -y install --no-install-recommends \
       git python python-lxml python-pip curl python-openssl \
       python-dev libffi-dev build-essential libssl-dev \
	&& pip install --upgrade setuptools==38.4.0 \
	&& pip install --upgrade pyopenssl==17.5.0 \
	&& curl -sLO https://archive.raspbian.org/raspbian/pool/main/d/dumb-init/dumb-init_1.0.3-1_armhf.deb \
    && dpkg -i dumb-init_*.deb \
    && rm -rf dumb-init_*.deb \
    && git clone https://github.com/CouchPotato/CouchPotatoServer.git --depth 1 /CouchPotatoServer \
    && apt-get remove --purge -y python-pip build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD couchpotato/ /etc/couchpotato/

VOLUME ['/data', '/config', '/downloads', '/movies', '/movies-ro']

RUN groupmod -g 1000 users \
    && useradd -u 911 -U -d /datadir -s /bin/false abc \
    && usermod -G users abc

# Expose port and run
EXPOSE 5050

CMD ["dumb-init", "/etc/couchpotato/start.sh"]

