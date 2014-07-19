# Substitute your own docker index username, if you like.
DOCKER_USER=internavenue
DOCKER_REPO_NAME=centos-base

# Change this to suit your needs.
CONTAINER_NAME:=lon-dev-app1
LOG_DIR:=/srv/docker/lon-dev-app1/log

RUNNING:=$(shell docker ps | grep "$(CONTAINER_NAME) " | cut -f 1 -d ' ')
ALL:=$(shell docker ps -a | grep "$(CONTAINER_NAME) " | cut -f 1 -d ' ')
DOCKER_RUN_COMMON=--name="$(CONTAINER_NAME)" -P -v $(LOG_DIR):/var/log $(DOCKER_USER)/$(DOCKER_REPO_NAME)

all: build

build:
	docker build -t="$(DOCKER_USER)/$(DOCKER_REPO_NAME)" .

run: clean
	mkdir -p $(LOG_DIR)
	docker run -d $(DOCKER_RUN_COMMON)

bash: clean
	mkdir -p $(LOG_DIR)
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
	sudo rm -rf $(LOG_DIR)
