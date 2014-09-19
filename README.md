# docker-centos-base

A Dockerfile that produces a Vagrant-ready, CentOS-based Docker base image.

## Included packages (and their dependencies)

* Midnight Commander
* OpenSSH client and server
* PWgen
* Puppet
* Screen
* Sudo
* Syslog-ng
* TMux
* VIM (Enhanced)

## Image Creation

This example creates the image with the tag `internavenue/centos-base`, but you can
change this to use your own username.


```
$ docker build -t="internavenue/centos-base" .
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

``` shell
$ mkdir -p /srv/docker/lon-dev-app1/log
$ docker run -d -name="app1" \
             -p 127.0.0.1:80:80 \
             -v /srv/docker/lon-dev-app1/log:/var/log \
             internavenue/centos-base
```

Alternately, you can run the following if you have *GNU Make* installed...

``` shell
$ make run
```

You can also specify a custom port to bind to on the host, such as SSHd.

``` shell
$ sudo mkdir -p /srv/docker/lon-dev-web
$ make run PORT=127.0.0.1:2222 \
           LOG_DIR=/my/spec/log/dir \
```

