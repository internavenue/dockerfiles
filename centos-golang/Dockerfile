FROM internavenue/centos-base

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

RUN yum -y install tar git mercurial bzr

ENV GOLANG_VERSION 1.4.2
ENV GOROOT /usr/local/go
ENV GOPATH /gopath

RUN mkdir $GOROOT
RUN mkdir $GOPATH

VOLUME $GOPATH

RUN curl https://storage.googleapis.com/golang/go$GOLANG_VERSION.linux-amd64.tar.gz | tar xvzf - -C $GOROOT --strip-components=1

ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin