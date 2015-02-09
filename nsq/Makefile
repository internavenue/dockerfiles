# Substitute your own docker index username, if you like.
DOCKER_USER=internavenue
DOCKER_REPO_NAME=nsqd:centos7

# Change this to suit your needs.
CONTAINER_NAME_NSQD:=lon-dev-nsqd1
CONTAINER_NAME_NSQLOOKUPD:=lon-dev-nsqlookupd1
CONTAINER_NAME_NSQADMIN:=lon-dev-nsqadmin1

DATA_DIR_NSQD:=/srv/docker/lon-dev-nsqd1/data

VAGRANT_DIR:=/srv/docker/lon-dev-nsqd1/vagrant
PORT_NSQADMIN:=127.0.0.1:4171

RUNNING_NSQD:=$(shell docker ps | grep "$(CONTAINER_NAME_NSQD) " | cut -f 1 -d ' ')
RUNNING_NSQLOOKUPD:=$(shell docker ps | grep "$(CONTAINER_NAME_NSQLOOKUPD) " | cut -f 1 -d ' ')
RUNNING_NSQADMIN:=$(shell docker ps | grep "$(CONTAINER_NAME_NSQADMIN) " | cut -f 1 -d ' ')

ALL_NSQD:=$(shell docker ps -a | grep "$(CONTAINER_NAME_NSQD) " | cut -f 1 -d ' ')
ALL_NSQLOOKUPD:=$(shell docker ps -a | grep "$(CONTAINER_NAME_NSQLOOKUPD) " | cut -f 1 -d ' ')
ALL_NSQADMIN:=$(shell docker ps -a | grep "$(CONTAINER_NAME_NSQADMIN) " | cut -f 1 -d ' ')

DOCKER_RUN_COMMON_NSQD=--name="$(CONTAINER_NAME_NSQD)"  \
	-v $(DATA_DIR_NSQD):/data \
	-v $(VAGRANT_DIR):/vagrant \
	--link $(CONTAINER_NAME_NSQLOOKUPD):$(CONTAINER_NAME_NSQLOOKUPD) \
	$(DOCKER_USER)/$(DOCKER_REPO_NAME)

DOCKER_RUN_COMMON_NSQLOOKUPD=--name="$(CONTAINER_NAME_NSQLOOKUPD)"  \
	-v $(VAGRANT_DIR):/vagrant \
	$(DOCKER_USER)/$(DOCKER_REPO_NAME)

DOCKER_RUN_COMMON_NSQADMIN=--name="$(CONTAINER_NAME_NSQADMIN)"  \
	-v $(VAGRANT_DIR):/vagrant \
	-p $(PORT_NSQADMIN):4171 \
	--link $(CONTAINER_NAME_NSQLOOKUPD):$(CONTAINER_NAME_NSQLOOKUPD) \
	$(DOCKER_USER)/$(DOCKER_REPO_NAME)

all: build

build:
	docker build -t="$(DOCKER_USER)/$(DOCKER_REPO_NAME)" .

nsqlookupd_run: nsqlookupd_clean
	docker run -d $(DOCKER_RUN_COMMON_NSQLOOKUPD) nsqlookupd

nsqlookupd_bash: nsqlookupd_clean
	docker run -t -i $(DOCKER_RUN_COMMON_NSQLOOKUPD) /bin/bash

nsqd_run: nsqd_clean
	mkdir -p $(DATA_DIR_NSQD)
	docker run -d $(DOCKER_RUN_COMMON_NSQD) nsqd --data-path /data --lookupd-tcp-address $(CONTAINER_NAME_NSQLOOKUPD):4160

nsqd_bash: nsqd_clean
	mkdir -p $(DATA_DIR_NSQD)
	docker run -t -i $(DOCKER_RUN_COMMON_NSQD) /bin/bash

nsqadmin_run: nsqadmin_clean
	docker run -d $(DOCKER_RUN_COMMON_NSQADMIN) nsqadmin --lookupd-http-address $(CONTAINER_NAME_NSQLOOKUPD):4161

nsqadmin_bash: nsqadmin_clean
	docker run -t -i $(DOCKER_RUN_COMMON_NSQADMIN) /bin/bash

run: nsqlookupd_run nsqd_run nsqadmin_run

# Removes existing containers.
nsqadmin_clean:
ifneq ($(strip $(RUNNING_NSQADMIN)),)
	docker stop $(RUNNING_NSQADMIN)
endif
ifneq ($(strip $(ALL_NSQADMIN)),)
	docker rm $(ALL_NSQADMIN)
endif

nsqd_clean:
ifneq ($(strip $(RUNNING_NSQD)),)
	docker stop $(RUNNING_NSQD)
endif
ifneq ($(strip $(ALL_NSQD)),)
	docker rm $(ALL_NSQD)
endif

nsqlookupd_clean:
ifneq ($(strip $(RUNNING_NSQLOOKUPD)),)
	docker stop $(RUNNING_NSQLOOKUPD)
endif
ifneq ($(strip $(ALL_NSQLOOKUPD)),)
	docker rm $(ALL_NSQLOOKUPD)
endif

clean: nsqadmin_clean nsqd_clean nsqlookupd_clean

# Destroys the data directory.
deepclean: clean
	sudo rm -rf $(DATA_DIR_NSQD)
