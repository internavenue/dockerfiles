# docker-centos-haproxy

A Dockerfile that produces a Vagrant-ready, CentOS 7-based Docker image that will run the latest stable [HAProxy][HAProxy].

The build is based on [internavenue/docker-centos-base][docker-centos-base].

[HAProxy]: http://www.haproxy.org/

## Included packages (and their dependencies)

* HAProxy

## Image Creation

This example creates the image with the tag `internavenue/centos-haproxy`, but you can
change this to use your own username.

```
$ docker build -t="internavenue/centos-haproxy" .
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

The HAProxy load balancer can be configured to use external volumes, such as
* /var/log - for logging
* /run - to access the haproxy.pid; useful if you want to send signals from the host
* /vagrant - if you want to the image with Vagrant
* /var/lib/haproxy - to examine runtime offline data that HAProxy produce.

This example uses `/srv/docker/lon-dev-haproxy` to host the web application, but you can modify
this to your needs.


``` shell
$ mkdir -p /srv/docker/lon-dev-haproxy
$ docker run -d -name="lon-dev-haproxy" \
             -p 127.0.0.1:80:80 \
             -v /srv/docker/lon-dev-haproxy/log:/var/log \
             -v /srv/docker/lon-dev-haproxy/run:/run \
             -v /srv/docker/lon-dev-haproxy/lib:/var/lib/haproxy \
             internavenue/centos-haproxy
```

Alternately, you can run the following if you have *GNU Make* installed...

``` shell
$ make run
```

You can also specify a custom port to bind to on the host, a custom web root
directory, and the superuser username and password on the host like so:

``` shell
$ sudo mkdir -p /srv/docker/lon-dev-haproxy
$ make run PORT=127.0.0.1:8080 \
           DATA_DIR=/my/spec/data/dir \
```

