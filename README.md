# docker-centos-phabricator

A Dockerfile that produces a CentOS-based Docker image that will run the latest stable [Phabricator bundle][phabricator].

The build is based on [internavenue/docker-centos-base][docker-centos-base].

[phabricator]: http://phabricator.org/
[docker-centos-base]: https://github.com/internavenue/docker-centos-base

## Included packages (and their dependencies)

* [internavenue/centos-base][centos-base]
* Phabricator (Phabricator, Arcanist, libphutil)
* Git

The example Makefile requires a container with [internavenue/docker-centos-percona][centos-percona] image.

[centos-base]: https://github.com/internavenue/docker-centos-base
[centos-percona]: https://github.com/internavenue/docker-centos-percona

## README.first

Unlike other Phabricator images, this one does not contain database server. This can be
quite handy for real world scenarios, where you MySQL server is multitenant.

The database server can be an other linked container such as [internavenue/docker-centos-percona][centos-percona] or
a standalone MySQL somewhere. In the later case the following variables needs to be passed to the container:

* `MYSQL_PORT_3306_TCP_ADDR`
* `MYSQL_PORT_3306_TCP_PORT`
* `MYSQL_ENV_USER`
* `MYSQL_ENV_PASS`

[centos-percona]: https://github.com/internavenue/docker-centos-percona

## Image Creation

This example creates the image with the tag `internavenue/centos-phabricator`, but you can
change this to use your own username.


```
$ docker build -t="internavenue/centos-phabricator" .
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

Phabricator's web root is `/srv/www/phabricator` inside the container.
You can map the container's `/srv/www/phabricatr` volume to a volume on the host so the data
becomes independant of the running container.

This example uses `/srv/docker/lon-dev-ph` to host the web application, but you can modify
this to your needs.

When the container runs, it creates a superuser with a random password.  You
can set the username and password for the superuser by setting the container's
environment variables.  This lets you discover the username and password of the
superuser from within a linked container or from the output of `docker inspect
web1`.

``` shell
$ mkdir -p /srv/docker/lon-dev-ph
$ docker run -d -name="ph" \
             -p 127.0.0.1:80:80 \
             -v /srv/docker/lon-dev-ph:/srv/www/phabricator \
             -e USER="super" \
             -e PASS="Whatz03v3r" \
             internavenue/centos-pabricator
```

Alternately, you can run the following if you have *GNU Make* installed...

``` shell
$ make run
```

You can also specify a custom port to bind to on the host, a custom web root
directory, and the superuser username and password on the host like so:

``` shell
$ sudo mkdir -p /srv/docker/lon-dev-ph
$ make run PH_PORT=127.0.0.1:80 \
           PH_DATA_DIR=/my/spec/data/dir \
           PH_LOG_DIR=/my/spec/log/dir \
           DB_DATA_DIR=/my/db/data/dir \
           DB_LOG_DIR=/my/db/log/dir \
           DB_USER=super \
           DB_PASS=Whatz03v3r
```
