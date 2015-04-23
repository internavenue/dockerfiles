FROM internavenue/centos-base:centos7

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

RUN yum install -y \
  bunzip2 \
  git \
  java-1.8.0-openjdk \
  java-1.8.0-openjdk-devel \
  npm \
  tar \
  unzip \
  && \
  yum clean all

RUN \
  curl http://mirrors.ukfast.co.uk/sites/ftp.apache.org/maven/maven-3/3.3.1/binaries/apache-maven-3.3.1-bin.zip -o apache-maven-3.3.1-bin.zip && \
  unzip apache-maven-3.3.1-bin.zip && \
  mv apache-maven-3.3.1/ /opt/maven && \
  ln -s /opt/maven/bin/mvn /usr/bin/mvn 

# Install zeppelin
RUN git clone  https://github.com/apache/incubator-zeppelin.git /zeppelin
WORKDIR /zeppelin
RUN mvn install -DskipTests

# Expose ports and run
EXPOSE 8080
EXPOSE 8081

CMD ["bin/zeppelin.sh", "start"]
