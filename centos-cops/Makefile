# Substitute your own Docker index username, if you like. 
# Database-related variables.
DOCKER_USER=internavenue
DOCKER_REPO_NAME=centos-cops:centos7

PORT:=127.0.0.1:9000

CONTAINER_NAME:=lon-dev-cops1

DATA_DIR:=/srv/docker/$(CONTAINER_NAME)/books
LOGS_DIR:=/srv/docker/$(CONTAINER_NAME)/log
RUN_DIR:=/srv/docker/$(CONTAINER_NAME)/run

RUNNING:=$(shell docker ps | grep "$(CONTAINER_NAME) " | cut -f 1 -d ' ')
ALL:=$(shell docker ps -a | grep "$(CONTAINER_NAME) " | cut -f 1 -d ' ')

DOCKER_RUN_COMMON=--name="$(CONTAINER_NAME)" -p $(PORT):9000 \
	-v $(DATA_DIR):/srv/books \
	-v $(LOGS_DIR):/var/log \
	-v $(RUN_DIR):/run \
	$(DOCKER_USER)/$(DOCKER_REPO_NAME)

all: build

dir:
	mkdir -p $(DATA_DIR)
	mkdir -p $(LOGS_DIR)
	mkdir -p $(RUN_DIR)

build:
	docker build -t="$(DOCKER_USER)/$(DOCKER_REPO_NAME)" .

run: clean
	docker run -d $(DOCKER_RUN_COMMON)

bash: clean dir
	docker run -t -i $(DOCKER_RUN_COMMON) /bin/bash

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
	sudo rm -rf $(RUN_DIR)
	sudo rm -rf $(LOGS_DIR)

