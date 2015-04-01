FROM internavenue/centos-php:centos7

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

# Install git to download Phabricator.
RUN \
   yum -y install git && \
   yum clean all

# Download Phabricator bundle.
RUN \
  mkdir -p /srv/www/phabricator && \
  mkdir -p /srv/git/

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /first_run

# Expose our web root and log directories log.
VOLUME ["/srv/www/phabricator", "/srv/git", "/var/log", "/run", "/vagrant"]

EXPOSE 9000 22

# Kicking in
CMD ["/scripts/start.sh"]

