#!/bin/bash -x
# this allows us to copy the source into the docker image without
# bothering to install git inside it. Also, this script outputs the git commit
# hash so we can tag the create image with it.
if ! test -d CouchPotatoServer;
then
	git clone https://github.com/CouchPotato/CouchPotatoServer.git --depth 1 CouchPotatoServer > /dev/null
	cd CouchPotatoServer/ && git log -1 --format=%h > tag && cd ..
	rm -rf CouchPotatoServer/.git
fi
cat CouchPotatoServer/tag