# Substitute your own Docker index username, if you like. 
# Database-related variables.
DB_DOCKER_USER=internavenue
DB_DOCKER_REPO_NAME=centos-percona
DB_CONTAINER_NAME:=lon-dev-db1

# Change this to suit your needs.
DB_USER:=super
DB_PASS:=Whatz03v3r

DB_PORT:=127.0.0.1:3306
DB_SSH_PORT:=127.0.0.1:2222

# These directories will be mounted in the containers.
DB_DATA_DIR:=/srv/docker/lon-dev-db1/mysql
DB_LOGS_DIR:=/srv/docker/lon-dev-db1/log

DB_RUNNING:=$(shell docker ps | grep "$(DB_CONTAINER_NAME) "| cut -f 1 -d ' ')
DB_ALL:=$(shell docker ps -a | grep "$(DB_CONTAINER_NAME) " | cut -f 1 -d ' ')

DB_DOCKER_RUN_COMMON=--name="$(DB_CONTAINER_NAME)" -p $(DB_PORT):3306 -p $(DB_SSH_PORT):22 \
	-v $(DB_DATA_DIR):/data \
	-v $(DB_LOGS_DIR):/var/log \
	-e USER="$(DB_USER)" -e PASS="$(DB_PASS)" $(DB_DOCKER_USER)/$(DB_DOCKER_REPO_NAME)


# SonarQube build part

# Substitute your own docker index username, if you like.
SQ_DOCKER_USER=internavenue
SQ_DOCKER_REPO_NAME=centos-sonarqube

# Change this to suit your needs.
SQ_CONTAINER_NAME:=lon-dev-sonar1
SQ_LOG_DIR:=/srv/docker/lon-dev-sonar1/log
SQ_DATA_DIR:=/srv/docker/lon-dev-sonar1/data

SQ_RUNNING:=$(shell docker ps | grep "$(SQ_CONTAINER_NAME) " | cut -f 1 -d ' ')
SQ_ALL:=$(shell docker ps -a | grep "$(SQ_CONTAINER_NAME) " | cut -f 1 -d ' ')

# Because of a bug, the container has to run as privileged,
# otherwise you end up with "could not open session" error.
SQ_DOCKER_RUN_COMMON=--name="$(SQ_CONTAINER_NAME)" \
	-P \
	-v $(SQ_LOG_DIR):/var/log \
	-v $(SQ_DATA_DIR):/opt/sonar \
	$(SQ_DOCKER_USER)/$(SQ_DOCKER_REPO_NAME)

all: build

dir:
	mkdir -p $(SQ_LOG_DIR)
	mkdir -p $(SQ_DATA_DIR)

build:
	docker build -t="$(SQ_DOCKER_USER)/$(SQ_DOCKER_REPO_NAME)" .

sq_run: sq_clean dir
	docker run -d $(SQ_DOCKER_RUN_COMMON)

sq_bash: sq_clean dir
	docker run --privileged -t -i $(SQ_DOCKER_RUN_COMMON) /bin/bash

# Removes existing containers.
sq_clean:
ifneq ($(strip $(SQ_RUNNING)),)
	docker stop $(SQ_RUNNING)
endif
ifneq ($(strip $(SQ_ALL)),)
	docker rm $(SQ_ALL)
endif

# Deletes the directories.
deepclean: clean
	sudo rm -rf $(SQ_LOG_DIR)
	sudo rm -rf $(SQ_DATA_DIR)
