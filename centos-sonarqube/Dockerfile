FROM internavenue/centos-base:centos7
MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

RUN wget -O /etc/yum.repos.d/sonar.repo http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo

RUN yum -y install \
  java-1.7.0-openjdk \
  yum install sonar

# Clean up YUM when done.
RUN yum clean all

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /first_run

# The --deaemon removed from the init file.
#ADD etc/jenkins /etc/init.d/jenkins
#RUN chmod +x /etc/init.d/jenkins

EXPOSE 8080 22

# Expose our web root and log directories log.
VOLUME ["/opt/sonar", "/var/log"]

# Kicking in
CMD ["/scripts/start.sh"]

