FROM internavenue/centos-base

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
RUN rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key

RUN yum -y install \
  java-1.7.0-openjdk \
  jenkins

# Clean up YUM when done.
RUN yum clean all

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /first_run

# The --deaemon removed from the init file.
ADD etc/jenkins /etc/init.d/jenkins
RUN chmod +x /etc/init.d/jenkins

EXPOSE 8080 22

# Expose our web root and log directories log.
VOLUME ["/var/lib/jenkins", "/var/log"]

# Kicking in
CMD ["/scripts/start.sh"]

