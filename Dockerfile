FROM internavenue/centos-nginx

MAINTAINER Intern Avenue Dev Team <dev@internavenue.com>

# Install Remi Collet's repo for CentOS 6
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN rpm -Uvh http://www.percona.com/downloads/percona-release/percona-release-0.0-1.x86_64.rpm

# Install PHP and Percona (MySQL) client stuff.
RUN yum -y install --enablerepo=remi,remi-php55 \
  Percona-Server-client-56 \
  php-fpm \
  php-cli \
  php-gd \
  php-ldap \
  php-mbstring \
  php-mcrypt \
  php-mysqlnd \
  php-pdo \
  php-pear \
  php-pecl-apc \
  php-pecl-imagick \
  php-soap \
  php-xml

# Clean up YUM when done.
RUN yum clean all

# Start Nginx and SSHd default.
RUN chkconfig --level 345 php-fpm on

ADD etc/fastcgi_params.conf /etc/nginx/conf/fastcgi_params.conf
RUN mv /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.default
ADD etc/www.conf /etc/php-fpm.d/www.conf

ADD etc/default.conf /etc/nginx/sites-available/default.conf
RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled

# Add Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

ADD scripts /scripts
RUN chmod +x /scripts/start.sh

# Expose our web root and log directories log.
VOLUME ["/srv/www", "/var/log"]

# Kicking in
CMD ["/scripts/start.sh"]

