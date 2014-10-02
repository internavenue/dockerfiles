FROM internavenue/centos-base:centos7

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

RUN yum -y install haproxy

# Clean up YUM when done.
RUN yum clean all

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /first_run

EXPOSE 80 443 22

# Expose our web root and log directories log.
VOLUME ["/vagrant", "/run", "/var/lib/haproxy", "/var/log"]

# Kicking in
CMD ["/scripts/start.sh"]

