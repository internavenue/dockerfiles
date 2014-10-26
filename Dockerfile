FROM internavenue/centos-percona:centos6
MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

# Install EPEL
RUN rpm -Uvh http://www.percona.com/downloads/percona-release/percona-release-0.0-1.x86_64.rpm

# Install base stuff.
RUN yum -y install \
  inotify-tools \
  Percona-Server-client-56 \
  Percona-Server-server-56 \
  Percona-Server-shared-56 \
  percona-xtrabackup \
  unzip 

# Clean up YUM when done.
RUN yum clean all

# Percona does not come with default config file.
ADD etc/my.cnf /etc/my.cnf
ADD etc/percona.init.sh /etc/init.d/percona
RUN chmod +x /etc/init.d/percona

# Start MySQL and SSHd by default.
RUN chkconfig --level 345 mysql on
RUN chkconfig --level 345 sshd on
#RUN /etc/init.d/mysql start

# Configure the database to use our data dir.
RUN sed -i -e 's/^datadir\s*=.*/datadir = \/data/' /etc/my.cnf

# Configure Percona to listen on any address.
RUN sed -i -e 's/^bind-address/#bind-address/' /etc/my.cnf

EXPOSE 3306 22

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /firstrun

# Change the root password. The password should be changed and/or managed via Puppet.
RUN sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && echo 'root:Ch4ng3M3' | chpasswd

# Expose our data, log, and configuration directories.
VOLUME ["/data", "/var/log", "/run"]

# Kicking in
CMD ["/scripts/start.sh"]
