FROM internavenue/centos-base:centos7

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

# SPARK
ENV SPARK_PROFILE 1.3
ENV SPARK_VERSION 1.3.1
ENV HADOOP_PROFILE 2.4
ENV HADOOP_VERSION 2.4.0

RUN yum install -y \
  bzip2 \
  git \
  java-1.8.0-openjdk \
  java-1.8.0-openjdk-devel \
  tar \
  unzip \
  && \
  yum clean all

RUN curl -sL --retry 3 \
  "http://apache.arvixe.com/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_PROFILE.tgz" \
  | gunzip \
  | tar x -C /opt/ \
  && ln -s /opt/spark-$SPARK_VERSION-bin-hadoop$HADOOP_PROFILE /opt/spark
