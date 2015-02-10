# Substitute your own docker index username, if you like.
DOCKER_USER=internavenue
DOCKER_REPO_NAME=centos-php:centos7

# Change this to suit your needs.
CONTAINER_NAME:=lon-dev-php1
DATA_DIR:=/srv/docker/lon-dev-php1/www
RUN_DIR:=/srv/docker/lon-dev-php1/run
LOG_DIR:=/srv/docker/lon-dev-php1/log
PORT:=127.0.0.1:9000

RUNNING:=$(shell docker ps | grep $(CONTAINER_NAME) | cut -f 1 -d ' ')
ALL:=$(shell docker ps -a | grep $(CONTAINER_NAME) | cut -f 1 -d ' ')
DOCKER_RUN_COMMON=--name="$(CONTAINER_NAME)" \
	--privileged \
	-p $(PORT):9000 \
	-v $(DATA_DIR):/srv/www \
	-v $(LOG_DIR):/var/log \
	-v $(RUN_DIR):/run \
	$(DOCKER_USER)/$(DOCKER_REPO_NAME)

all: build

dir:
	mkdir -p $(DATA_DIR)
	mkdir -p $(LOG_DIR)
	mkdir -p $(RUN_DIR)

build:
	docker build -t="$(DOCKER_USER)/$(DOCKER_REPO_NAME)" .

run: clean dir
	docker run -d $(DOCKER_RUN_COMMON)

bash: clean dir
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
	sudo rm -rf $(RUN_DIR)
	sudo rm -rf $(LOG_DIR)

