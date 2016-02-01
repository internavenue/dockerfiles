FROM internavenue/centos-base:centos7

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

ENV PIO_VERSION 0.9.5

RUN yum install -y \
  bzip2 \
  git \
  java-1.8.0-openjdk \
  java-1.8.0-openjdk-devel \
  python-setuptools python-dev python-numpy \
  tar \
  unzip \
  && \
  yum clean all

#WORKDIR /

#RUN curl https://d8k1yxp8elc6b.cloudfront.net/PredictionIO-$PIO_VERSION.tar.gz | tar xvz 

#RUN mkdir -p /PredictionIO-$PIO_VERSION/vendors

#WORKDIR PredictionIO-$PIO_VERSION/vendors

#RUN curl https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.4.tar.gz | tar xvz

#RUN curl http://archive.apache.org/dist/hbase/hbase-1.0.0/hbase-1.0.0-bin.tar.gz | tar xvz

WORKDIR /vagrant
