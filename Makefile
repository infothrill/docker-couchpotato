SUFFIXi ?= ""
DOCKER_IMAGE_VERSION=$(shell ./prepare_source.sh)
DOCKER_IMAGE_NAME=infothrill/rpi-couchpotato$(SUFFIX)
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

build:
	docker build -t $(DOCKER_IMAGE_TAGNAME) -f Dockerfile$(SUFFIX) .
	docker tag $(DOCKER_IMAGE_TAGNAME) $(DOCKER_IMAGE_NAME):latest

push:
	docker push $(DOCKER_IMAGE_TAGNAME)
	docker push $(DOCKER_IMAGE_NAME)

test:
	docker run --rm $(DOCKER_IMAGE_TAGNAME) /bin/echo "Success."
	docker run --rm $(DOCKER_IMAGE_TAGNAME) /usr/bin/python /CouchPotatoServer/CouchPotato.py --help

rmi:
	docker rmi -f $(DOCKER_IMAGE_TAGNAME)

rebuild: rmi build
