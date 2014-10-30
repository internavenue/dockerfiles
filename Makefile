# Substitute your own docker index username, if you like.
DOCKER_USER=internavenue

# Change this to suit your needs.
CONTAINER_NAME:=lon-dev-db
USER:=super
PASS:=Whatz03v3r
DATA_DIR:=/srv/docker/lon-dev-db/data
LOG_DIR:=/srv/docker/lon-dev-db/log
RUN_DIR:=/srv/docker/lon-dev-db/run
PORT:=127.0.0.1:3306

RUNNING:=$(shell docker ps | grep $(CONTAINER_NAME) | cut -f 1 -d ' ')
ALL:=$(shell docker ps -a | grep $(CONTAINER_NAME) | cut -f 1 -d ' ')
DOCKER_RUN_COMMON=\
									--name="$(CONTAINER_NAME)" \
									-p $(PORT):3306 \
									-v $(DATA_DIR):/data \
									-v $(LOG_DIR):/var/log \
									-v $(RUN_DIR):/run \
									-e USER="$(USER)" \
									-e PASS="$(PASS)" \
									$(DOCKER_USER)/centos-percona:centos6

all: build

build:
	docker build -t="$(DOCKER_USER)/centos-percona:centos6" .

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
