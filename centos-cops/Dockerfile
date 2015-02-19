FROM internavenue/centos-php:centos7

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

RUN \
  yum -y install tar php-sqlite && \
  yum clean all

# Explicit version installed, so we know we won't break anything.
RUN \
  mkdir -p /srv/books && \
  curl -SL https://github.com/seblucas/cops/archive/1.0.0RC3.tar.gz | \
  tar -xzC /srv && \
  mv /srv/cops-1.0.0RC3 /srv/cops

ADD etc/config_local.php /srv/cops/config_local.php

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /first_run

# Expose our web root and log directories log.
VOLUME ["/srv/books", "/var/log", "/run", "/vagrant"]

# Kicking in
CMD ["/scripts/start.sh"]

