FROM internavenue/centos-base:centos7

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

RUN curl -SL http://pkg.jenkins-ci.org/redhat/jenkins.repo -o /etc/yum.repos.d/jenkins.repo && \
  rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key

RUN yum -y install \
  bzip2 \
  java-1.8.0-openjdk \
  java-1.8.0-openjdk-devel \
  git \
  initscripts \
  tar \
  jenkins && \
  yum clean all

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /first_run

# The --deaemon removed from the init file.
ADD etc/jenkins /etc/init.d/jenkins.nodaemon
RUN chmod +x /etc/init.d/jenkins.nodaemon

EXPOSE 8080 22

# Expose our web root and log directories log.
VOLUME ["/var/lib/jenkins", "/var/log", "/run", "/vagrant"]

# Kicking in
CMD ["/scripts/start.sh"]

