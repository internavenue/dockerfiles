# docker-centos-php

A Docker build that produces a CentOS-based Docker image that will run the latest stable PHP and [Nginx][nginx] web server.

The build is based on [internavenue/docker-centos-nginx][docker-centos-nginx].

[docker-centos-nginx]: https://github.com/internavenue/docker-centos-nginx
[nginx]: http://nginx.org/

## Included packages (and their dependencies)

The 

* PHP 5.5.x and its extensions: php-gd, php-ldap, php-mbstring, php-mcrypt, php-mysqlnd, php-pdo, php-pear, php-pecl-apc, php-pecl-imagick, php-soap, php-xml
* PHP-FPM
* Percona 5.6 client which provides libmysqlclient, a dependency for php-mysqlnd and php-pdo. This is simple matter of taste, the CentOS default MariaDB client could be also fine, but our other MySQL-ish Docker build, the [internavenue/docker-centos-percona][docker-centos-percona] is based on Percona, we wanted to be consistent here.
* Composer
* Nginx
* [Puppet][puppet]
* [tmux][tmux]
* Screen 
* VIM (Enhanced)
* Midnight Commander
* OpenSSH client and server
* PWgen

[puppet]: http://puppetlabs.com/puppet
[tmux]: http://en.wikipedia.org/wiki/Tmux

## Image Creation

This example creates the image with the tag `internavenue/centos-php`, but you can
change this to use your own username.


```
$ docker build -t="internavenue/centos-php" .
```

Alternately, you can run the following if you have *GNU Make* installed...

```
$ make
```

You can also specify a custom docker username like so:

```
$ make DOCKER_USER=internavenue
```

## Container Creation / Running

The Nginx web server is configured to store web root in `/srv/www` inside the container.
You can map the container's `/srv/www` volume to a volume on the host so the data
becomes independant of the running container.

This example uses `/srv/docker/lon-dev-web` to host the web application, but you can modify
this to your needs.

When the container runs, it creates a superuser with a random password.  You
can set the username and password for the superuser by setting the container's
environment variables.  This lets you discover the username and password of the
superuser from within a linked container or from the output of `docker inspect
web1`.

``` shell
$ mkdir -p /srv/docker/lon-dev-web
$ docker run -d -name="web1" \
             -p 127.0.0.1:80:80 \
             -v /srv/docker/lon-dev-web:/srv/www \
             -e USER="super" \
             -e PASS="Whatz03v3r" \
             internavenue/nginx
```

Alternately, you can run the following if you have *GNU Make* installed...

``` shell
$ make run
```

You can also specify a custom port to bind to on the host, a custom web root
directory, and the superuser username and password on the host like so:

``` shell
$ sudo mkdir -p /srv/docker/lon-dev-web
$ make run PORT=127.0.0.1:8080 \
           DATA_DIR=/my/spec/data/dir \
           USER=super \
           PASS=Whatz03v3r
```

