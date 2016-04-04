FROM internavenue/centos-base:centos7

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

RUN yum install -y \
  bzip2 \
  git \
  java-1.8.0-openjdk \
  java-1.8.0-openjdk-devel \
  python-setuptools python-dev python-numpy \
  npm \
  tar \
  unzip \
  R \
  && \
  yum clean all

RUN \
  curl http://mirrors.ukfast.co.uk/sites/ftp.apache.org/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.zip -o apache-maven-3.3.3-bin.zip && \
  unzip apache-maven-3.3.3-bin.zip && \
  mv apache-maven-3.3.3/ /opt/maven && \
  ln -s /opt/maven/bin/mvn /usr/bin/mvn


# Py4j for PySpark
RUN easy_install py4j


VOLUME ["/vagrant", "/zeppelin", "/zeppelin/run", "/zeppelin/log", "/zeppelin/notebook"]

EXPOSE 8080 8081

CMD ["scripts/setup.sh"]
