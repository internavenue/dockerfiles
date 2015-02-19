FROM internavenue/centos-php:centos7

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

RUN yum -y install git php-sqlite 

RUN yum clean all

RUN mkdir -p /srv/www && \
    mkdir -p /srv/books

RUN git clone https://github.com/seblucas/cops.git /srv/www/cops
ADD etc/config_local.php /srv/www/cops/config_local.php

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /first_run

# Expose our web root and log directories log.
VOLUME ["/srv/www/cops", "/srv/books", "/var/log", "/run", "/vagrant"]

# Kicking in
CMD ["/scripts/start.sh"]

