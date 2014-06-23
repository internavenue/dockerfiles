# Substitute your own docker index username, if you like.
DOCKER_USER=internavenue

# Change this to suit your needs.
CONTAINER_NAME:=lon-dev-db1
USER:=super
PASS:=Whatz03v3r
DATA_DIR:=/srv/docker/lon-dev-db1
PORT:=127.0.0.1:3306

RUNNING:=$(shell docker ps | grep $(NAME) | cut -f 1 -d ' ')
ALL:=$(shell docker ps -a | grep $(NAME) | cut -f 1 -d ' ')
DOCKER_RUN_COMMON=--name="$(NAME)" -p $(PORT):3306 -v $(DATA_DIR):/data -e USER="$(USER)" -e PASS="$(PASS)" $(DOCKER_USER)/centos-percona

all: build

build:
docker build -t="$(DOCKER_USER)/centos-percona" .

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
