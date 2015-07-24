FROM internavenue/centos-base:centos7

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

ENV SCALA_URL http://downloads.typesafe.com/scala
ENV SCALA_VERSION 2.11.7

RUN yum install -y \
  git \
  tar \
  unzip \
  wget \
  java-1.8.0-openjdk \
  java-1.8.0-openjdk-devel \
  npm && \
  yum clean all

#Install Scala
RUN \
  curl $SCALA_URL/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xvz
RUN \
  mv scala-$SCALA_VERSION /usr/lib/ && \
  ln -s /usr/lib/scala-$SCALA_VERSION /usr/lib/scala

ENV PATH $PATH:/usr/lib/scala/bin

#Install sbt
RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo 
RUN yum install -y sbt

#Install NLP4L
RUN git clone https://github.com/NLP4L/nlp4l /nlp4l
WORKDIR /nlp4l
RUN sbt pack
