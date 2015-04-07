# Substitute your own docker index username, if you like.
DOCKER_USER=internavenue
DOCKER_REPO_NAME=centos-haproxy:centos7

# Change this to suit your needs.
CONTAINER_NAME:=lon-dev-haproxy
LOG_DIR:=/srv/docker/lon-dev-haproxy1/log
DATA_DIR:=/srv/docker/lon-dev-haproxy1/lib
RUN_DIR:=/srv/docker/lon-dev-haproxy1/run

RUNNING:=$(shell docker ps | grep "$(CONTAINER_NAME) " | cut -f 1 -d ' ')
ALL:=$(shell docker ps -a | grep "$(CONTAINER_NAME) " | cut -f 1 -d ' ')

# Because of a bug, the container has to run as privileged,
# otherwise you end up with "could not open session" error.
DOCKER_RUN_COMMON=--name="$(CONTAINER_NAME)" \
	-P --privileged=true \
	-v $(LOG_DIR):/var/log \
	-v $(DATA_DIR):/var/lib/haproxy \
	-v $(RUN_DIR):/run \
	$(DOCKER_USER)/$(DOCKER_REPO_NAME)

all: build

build:
	docker build -t="$(DOCKER_USER)/$(DOCKER_REPO_NAME)" .

run: clean
	mkdir -p $(LOG_DIR)
	mkdir -p $(DATA_DIR)
	mkdir -p $(RUN_DIR)
	docker run -d $(DOCKER_RUN_COMMON)

bash: clean
	mkdir -p $(LOG_DIR)
	mkdir -p $(DATA_DIR)
	mkdir -p $(RUN_DIR)
	docker run -t -i $(DOCKER_RUN_COMMON) /bin/bash

# Removes existing containers.
clean:
ifneq ($(strip $(RUNNING)),)
	docker stop $(RUNNING)
endif
ifneq ($(strip $(ALL)),)
	docker rm $(ALL)
endif

# Deletes the directories.
deepclean: clean
	sudo rm -rf $(LOG_DIR)
	sudo rm -rf $(DATA_DIR)
	sudo rm -rf $(RUN_DIR)
