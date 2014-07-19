# docker-centos-nginx

A Dockerfile that produces a CentOS-based Docker image that will run the latest stable [Nginx][nginx].

It is ideal to be a base image to serve out [PHP-FPM][phpfpm] or as a [Puppet Master][puppet] load balancer.

The build is based on [internavenue/docker-centos-base][docker-centos-base].

[nginx]: http://nginx.org/
[phpfpm]: http://php-fpm.org/
[puppet]: http://puppetlabs.com/puppet

## Included packages (and their dependencies)

* Nginx
* [H5BP Nginx boilerplate][h5bp]

[h5bp]: https://github.com/h5bp/server-configs-nginx

## Image Creation

This example creates the image with the tag `internavenue/centos-nginx`, but you can
change this to use your own username.


```
$ docker build -t="internavenue/centos-nginx" .
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

