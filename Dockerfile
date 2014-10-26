FROM internavenue/centos-percona:centos7
MAINTAINER Intern Avenue Dev Team2 <dev@internavenue.com>

# Install EPEL
RUN rpm -Uvh http://www.percona.com/downloads/percona-release/percona-release-0.0-1.x86_64.rpm

# Install base stuff.
RUN yum -y install \
  Percona-Server-client-56 \
  Percona-Server-server-56 \
  Percona-Server-shared-56 \
  percona-xtrabackup \
  unzip 

# The inotify-tools is not available in the stable repo (yet).
RUN yum install -y --enablerepo=epel-testing inotify-tools

# Clean up YUM when done.
RUN yum clean all

# Percona does not come with default config file.
ADD etc/my.cnf /etc/my.cnf
ADD etc/percona.init.sh /etc/init.d/percona
RUN chmod +x /etc/init.d/percona

# Configure the database to use our data dir.
RUN sed -i -e 's/^datadir\s*=.*/datadir = \/data/' /etc/my.cnf

# Configure Percona to listen on any address.
RUN sed -i -e 's/^bind-address/#bind-address/' /etc/my.cnf

EXPOSE 3306 22

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /first_run

# Expose our data, log, and configuration directories.
VOLUME ["/vagrant", "/data", "/var/log", "/run"]

# Kicking in
CMD ["/scripts/start.sh"]
