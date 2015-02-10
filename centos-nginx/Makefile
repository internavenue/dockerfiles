# Substitute your own docker index username, if you like.
DOCKER_USER=internavenue
DOCKER_REPO_NAME=centos-nginx:centos7

# Change this to suit your needs.
CONTAINER_NAME:=lon-dev-web1
USER:=super
PASS:=Whatz03v3r
DATA_DIR:=/srv/docker/lon-dev-web1/www
LOG_DIR:=/srv/docker/lon-dev-web1/log
RUN_DIR:=/srv/docker/lon-dev-web1/run
VAGRANT_DIR:=/srv/docker/lon-dev-web1/vagrant
PORT:=127.0.0.1:81

RUNNING:=$(shell docker ps | grep $(CONTAINER_NAME) | cut -f 1 -d ' ')
ALL:=$(shell docker ps -a | grep $(CONTAINER_NAME) | cut -f 1 -d ' ')
DOCKER_RUN_COMMON=--name="$(CONTAINER_NAME)" -p $(PORT):80 \
	-P --privileged=true \
	-v $(DATA_DIR):/srv/www \
	-v $(LOG_DIR):/var/log \
	-v $(RUN_DIR):/var/run \
	-v $(VAGRANT_DIR):/vagrant \
	-e USER="$(USER)" -e PASS="$(PASS)" $(DOCKER_USER)/$(DOCKER_REPO_NAME)

all: build

build:
	docker build -t="$(DOCKER_USER)/$(DOCKER_REPO_NAME)" .

run: clean
	mkdir -p $(DATA_DIR)
	docker run -d $(DOCKER_RUN_COMMON)

bash: clean
	mkdir -p $(DATA_DIR)
	docker run -t -i $(DOCKER_RUN_COMMON) /bin/bash

# Removes existing containers.
clean:
ifneq ($(strip $(RUNNING)),)
	docker stop $(RUNNING)
endif
ifneq ($(strip $(ALL)),)
	docker rm $(ALL)
endif

# Destroys the data directory.
deepclean: clean
	sudo rm -rf $(DATA_DIR)
