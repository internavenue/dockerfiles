FROM centos

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

RUN yum update -y
RUN yum install -y git \
    wget \
    unzip \
    npm && \
    yum clean all

# Update list of packages
RUN yum check-update

# install Oracle Java 7
RUN wget --continue --no-check-certificate --header "Cookie: oraclelicense=a" -O jdk-linux-x64.rpm "http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.rpm"

RUN yum localinstall -y jdk-linux-x64.rpm

RUN rm jdk-linux-x64.rpm

ENV JAVA_HOME /usr/java/default

#Install maven
RUN wget http://mirrors.ukfast.co.uk/sites/ftp.apache.org/maven/maven-3/3.3.1/binaries/apache-maven-3.3.1-bin.zip

RUN unzip apache-maven-3.3.1-bin.zip

RUN mv apache-maven-3.3.1/ /opt/maven

RUN ln -s /opt/maven/bin/mvn /usr/bin/mvn

# Install zeppelin
RUN git clone  https://github.com/apache/incubator-zeppelin.git /zeppelin
WORKDIR /zeppelin
RUN mvn install -DskipTests

# Expose ports and run
EXPOSE 8080
EXPOSE 8081

CMD ["bin/zeppelin.sh", "start"]
