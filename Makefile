# TAG os provided by external shell script
TAG=$(shell ./prepare_source.sh)
# DIR points to the directory with the Dockerfile to be built:
DIR ?= $(addprefix $(PWD), /x86-alpine)
DOCKER_REPO ?= couchpotato-$(shell basename $(DIR))
IMAGE_NAME ?= $(DOCKER_REPO):$(TAG)

default: build

build:
	docker build -t $(IMAGE_NAME) -f $(DIR)/Dockerfile .
	docker tag $(IMAGE_NAME) $(DOCKER_REPO):latest

push:
	docker push $(IMAGE_NAME)
	docker push $(DOCKER_REPO)

test:
	docker run --rm $(IMAGE_NAME) /bin/echo "Success."
	docker run --rm $(IMAGE_NAME) /usr/bin/python /CouchPotatoServer/CouchPotato.py --help

rmi:
	docker rmi -f $(IMAGE_NAME)

post_checkout:
	docker run --rm --privileged multiarch/qemu-user-static:register --reset

post_push:
	docker tag $(IMAGE_NAME) $(DOCKER_REPO):$(TAG)
	docker push $(DOCKER_REPO):$(TAG)

rebuild: rmi build
