FROM internavenue/centos-base

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

# Install the Nginx.org CentOS repo.
ADD etc/nginx.repo /etc/yum.repos.d/nginx.repo

# Install base stuff.
RUN yum -y install \
  nginx \

# Clean up YUM when done.
RUN yum clean all

RUN mkdir /srv/www

# Replace the stock config with a nicer one.
RUN rm -rf /etc/nginx
ADD etc/nginx /etc/nginx
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

# Change the root password. The password should be changed and/or managed via Puppet.
RUN sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && echo 'root:Ch4ng3M3' | chpasswd

# Expose our web root and log directories log.
VOLUME ["/srv/www", "/var/log"]

# Kicking in
CMD ["/scripts/start.sh"]

