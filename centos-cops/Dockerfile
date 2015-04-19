FROM internavenue/centos-php:centos7

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

RUN \
  yum -y --enablerepo=remi,remi-php56 install \
    git \
    php-pecl-sqlite && \
  yum clean all

# Explicit version installed, so we know we won't break anything.
RUN \
  mkdir -p /srv/books && \
  mkdir -p /srv/www/

ADD etc/config_local.php /srv/www/config_local.php

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /first_run

# Expose our web root and log directories log.
VOLUME ["/srv/www/cops", "/srv/books", "/var/log", "/run", "/vagrant"]

# Kicking in
CMD ["/scripts/start.sh"]

