FROM internavenue/centos-base:centos7

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

# SPARK 
ENV SPARK_PROFILE 1.6
ENV SPARK_VERSION 1.6.0
ENV HADOOP_PROFILE 2.6
ENV HADOOP_VERSION 2.6.0

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

RUN curl -sL --retry 3 \
  "http://mirrors.ibiblio.org/apache/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_PROFILE.tgz" \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s /usr/spark-$SPARK_VERSION-bin-hadoop$HADOOP_PROFILE /usr/spark \
  && rm -rf /usr/spark/examples \
  && rm /usr/spark/lib/spark-examples*.jar

RUN \
  curl http://mirrors.ukfast.co.uk/sites/ftp.apache.org/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.zip -o apache-maven-3.3.3-bin.zip && \
  unzip apache-maven-3.3.3-bin.zip && \
  mv apache-maven-3.3.3/ /opt/maven && \
  ln -s /opt/maven/bin/mvn /usr/bin/mvn

# Install Zeppelin
RUN git clone  https://github.com/apache/incubator-zeppelin.git /zeppelin
WORKDIR /zeppelin
RUN mvn clean package -DskipTests -Pspark-$SPARK_PROFILE -Dspark.version=$SPARK_VERSION


# Py4j for PySpark
RUN easy_install py4j

CMD ["bin/zeppelin-daemon.sh", "start"]

VOLUME ["/vagrant", "/zeppelin/run", "/zeppelin/log", "/zeppelin/notebook"]

EXPOSE 8080 8081
