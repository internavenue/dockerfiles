FROM internavenue/centos-base:centos7

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

# Install the Nginx.org CentOS repo.
ADD etc/nginx.repo /etc/yum.repos.d/nginx.repo

# Install base stuff.
RUN yum -y install \
  nginx \
  unzip

# Clean up YUM when done.
RUN yum clean all

RUN mkdir /srv/www

# Replace the stock config with a nicer one.
RUN rm -rf /etc/nginx

# Unfortunately, because of a bug in hub.docker.com,
# we can't use Git submodules here to drop modules in.
RUN cd /tmp && \
  wget -O server-configs-nginx.zip https://github.com/h5bp/server-configs-nginx/archive/master.zip && \
  unzip server-configs-nginx.zip && \
  mv server-configs-nginx-master /etc/nginx

RUN mkdir /etc/nginx/conf
RUN sed -ri 's/user www www;/user nginx nginx;\n\n# Run Nginx in the foreground for Docker.\ndaemon off;/g' /etc/nginx/nginx.conf
RUN sed -ri 's/logs\/error.log/\/var\/log\/nginx\/error.log/g' /etc/nginx/nginx.conf
RUN sed -ri 's/logs\/access.log/\/var\/log\/nginx\/access.log/g' /etc/nginx/nginx.conf
RUN sed -ri 's/logs\/static.log/\/var\/log\/nginx\/static.log/g' /etc/nginx/h5bp/location/expires.conf

# Don't run Nginx as a daemon. This lets the docker host monitor the process.
RUN ln -s /etc/nginx/sites-available/no-default /etc/nginx/sites-enabled

EXPOSE 80 22

ADD scripts /scripts
RUN chmod +x /scripts/start.sh

# Expose our web root and log directories log.
VOLUME ["/vagrant", "/srv/www", "/var/log", "/var/run"]

# Kicking in
CMD ["/scripts/start.sh"]

