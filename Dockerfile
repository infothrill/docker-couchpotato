# Couchpotato for raspberry pi

FROM resin/rpi-raspbian:jessie

# Update packages and install software
RUN apt-get update \
    && apt-get -y install git python python-lxml python-pip curl python-openssl python-dev libffi-dev build-essential libssl-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# https://github.com/ansible/ansible/issues/31741:
RUN pip install --upgrade setuptools
RUN pip install pyopenssl --upgrade

RUN curl -sLO https://archive.raspbian.org/raspbian/pool/main/d/dumb-init/dumb-init_1.0.3-1_armhf.deb \
    && dpkg -i dumb-init_*.deb \
    && rm -rf dumb-init_*.deb

ADD couchpotato/ /etc/couchpotato/

VOLUME /datadir

RUN groupmod -g 1000 users \
    && useradd -u 911 -U -d /datadir -s /bin/false abc \
    && usermod -G users abc

RUN mkdir /app && \
    cd /app && \
    git clone https://github.com/CouchPotato/CouchPotatoServer.git --depth 1

# Expose port and run
EXPOSE 5050

CMD ["dumb-init", "/etc/couchpotato/start.sh"]

