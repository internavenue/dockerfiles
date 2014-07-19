# Substitute your own Docker index username, if you like. 
# Database-related variables.
DB_DOCKER_USER=internavenue
DB_DOCKER_REPO_NAME=centos-percona
DB_CONTAINER_NAME:=lon-dev-db

# Change this to suit your needs.
DB_USER:=super
DB_PASS:=Whatz03v3r

DB_PORT:=127.0.0.1:3306
DB_SSH_PORT:=127.0.0.1:2222

# These directories will be mounted in the containers.
DB_DATA_DIR:=/storage/docker/lon-dev-db/mysql
DB_LOGS_DIR:=/storage/docker/lon-dev-db/log

DB_RUNNING:=$(shell docker ps | grep $(DB_CONTAINER_NAME) | cut -f 1 -d ' ')
DB_ALL:=$(shell docker ps -a | grep $(DB_CONTAINER_NAME) | cut -f 1 -d ' ')

DB_DOCKER_RUN_COMMON=--name="$(DB_CONTAINER_NAME)" -p $(DB_PORT):3306 -p $(DB_SSH_PORT):22 \
	-v $(DB_DATA_DIR):/data \
	-v $(DB_LOGS_DIR):/var/log/mysql \
	-e USER="$(DB_USER)" -e PASS="$(DB_PASS)" $(DB_DOCKER_USER)/$(DB_DOCKER_REPO_NAME)


# Phabricator-related variables.

PH_DOCKER_USER=internavenue
PH_DOCKER_REPO_NAME=centos-phabricator

PH_PORT:=127.0.0.1:80

PH_DATA_DIR:=/storage/docker/lon-dev-ph/www
PH_REPO_DIR:=/storage/docker/lon-dev-ph/git
PH_LOGS_DIR:=/storage/docker/lon-dev-ph/log

PH_CONTAINER_NAME:=lon-dev-ph

PH_RUNNING:=$(shell docker ps | grep $(PH_CONTAINER_NAME) | cut -f 1 -d ' ')
PH_ALL:=$(shell docker ps -a | grep $(PH_CONTAINER_NAME) | cut -f 1 -d ' ')

PH_DOCKER_RUN_COMMON=--name="$(PH_CONTAINER_NAME)" -p $(PH_PORT):80 \
	-v $(PH_DATA_DIR):/srv/www/phabricator \
	-v $(PH_REPO_DIR):/srv/git \
	-v $(PH_LOGS_DIR):/var/log \
	-e DB_USER="$(DB_USER)" -e DB_PASS="$(DB_PASS)" \
	--link $(DB_CONTAINER_NAME):mysql $(PH_DOCKER_USER)/$(PH_DOCKER_REPO_NAME)


all: build

build:
	docker build -t="$(PH_DOCKER_USER)/$(PH_DOCKER_REPO_NAME)" .

ph_run:  
	mkdir -p $(PH_DATA_DIR)
	mkdir -p $(PH_REPO_DIR)
	mkdir -p $(PH_LOGS_DIR)
	docker run -d $(PH_DOCKER_RUN_COMMON)

db_bash: clean
	mkdir -p $(DB_DATA_DIR)
	docker run -t -i $(DB_DOCKER_RUN_COMMON) /bin/bash

db_run: clean
	mkdir -p $(DB_DATA_DIR)
	docker run -d $(DB_DOCKER_RUN_COMMON)

run: clean db_run ph_run

bash: ph_clean db_clean db_run
	mkdir -p $(PH_DATA_DIR)
	mkdir -p $(PH_REPO_DIR)
	mkdir -p $(PH_LOGS_DIR)
	docker run -t -i $(PH_DOCKER_RUN_COMMON) /bin/bash

clean:
ifneq ($(strip $(DB_RUNNING)),)
	docker stop $(DB_RUNNING)
endif
ifneq ($(strip $(DB_ALL)),)
	docker rm $(DB_ALL)
endif

ifneq ($(strip $(PH_RUNNING)),)
	docker stop $(PH_RUNNING)
endif
ifneq ($(strip $(PH_ALL)),)
	docker rm $(PH_ALL)
endif

ph_clean:
	PH_RUNNING=`docker ps | grep ${PH_CONTAINER_NAME} | cut -f 1 -d ' '`
	docker stop ${PH_RUNNING}
	PH_ALL=`docker ps -a | grep ${PH_CONTAINER_NAME} | cut -f 1 -d ' '`
	docker rm ${PH_ALL}

# Destroys the data directory.
ph_deepclean: ph_clean
	sudo rm -rf $(PH_DATA_DIR)
	sudo rm -rf $(PH_REPO_DIR)
	sudo rm -rf $(PH_LOGS_DIR)
