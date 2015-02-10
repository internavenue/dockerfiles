FROM internavenue/centos-base:centos7

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

# Install Remi Collet's repo for CentOS 7
RUN yum -y install \
  http://rpms.famillecollet.com/enterprise/remi-release-6.rpm \
  http://www.percona.com/downloads/percona-release/percona-release-0.0-1.x86_64.rpm \
  ftp://rpmfind.net/linux/centos/6.6/os/x86_64/Packages/OpenEXR-libs-1.6.1-8.1.el6.x86_64.rpm

# Install PHP and Percona (MySQL) client stuff and the latest stable PHP.
RUN yum -y install --enablerepo=remi,remi-php56 \
  Percona-Server-client-56 \
  php-fpm \
  php-cli \
  php-gd \
  php-mbstring \
  php-mcrypt \
  php-mysqlnd \
  php-pdo \
  php-pear \
  php-pecl-imagick \
  php-soap \
  php-xml

# Clean up YUM when done.
RUN yum clean all

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /first_run

RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php.ini
ADD etc/fastcgi_params.conf /etc/nginx/conf/fastcgi_params.conf
RUN mv /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.default
ADD etc/www.conf /etc/php-fpm.d/www.conf

# Add Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

ADD scripts /scripts
RUN chmod +x /scripts/start.sh

# Expose our web root and log directories log.
VOLUME ["/srv/www", "/var/log", "/var/lib/php", "/run", "/vagrant"]

EXPOSE 9000 22

# Kicking in
CMD ["/scripts/start.sh"]

