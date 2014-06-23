# docker-centos-percona

A Dockerfile that produces a  Centos-based Docker image that will run the latest stable [Percona][percona].

This Dockerfile and the scripts are based on [Ryan Seto][paintedfox]'s excellent [docker-mariadb][docker-mariadb]
repo. Thanks, mate!

[percona]: http://www.percona.com/software/percona-server
[paintedfox]: https://github.com/Painted-Fox
[docker-mariadb]: https://github.com/Painted-Fox/docker-mariadb

## Image Creation

This example creates the image with the tag `internavenue/centos-percona`, but you can
change this to use your own username.


```
$ docker build -t="internavenue/centos-percona" .
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

The Percona server is configured to store data in `/data` inside the container.
You can map the container's `/data` volume to a volume on the host so the data
becomes independant of the running container.

This example uses `/srv/docker/lon-dev-db1` to store the MariaDB data, but you can modify
this to your needs.

When the container runs, it creates a superuser with a random password.  You
can set the username and password for the superuser by setting the container's
environment variables.  This lets you discover the username and password of the
superuser from within a linked container or from the output of `docker inspect
percona1`.

``` shell
$ mkdir -p /srv/docker/lon-dev-db1
$ docker run -d -name="percona1" \
             -p 127.0.0.1:3306:3306 \
             -v /srv/docker/lon-dev-db1:/data \
             -e USER="super" \
             -e PASS="Whatz03v3r" \
             internavenue/centos-percona
```

Alternately, you can run the following if you have *GNU Make* installed...

``` shell
$ make run
```

You can also specify a custom port to bind to on the host, a custom data
directory, and the superuser username and password on the host like so:

``` shell
$ sudo mkdir -p /srv/docker/lon-dev-db1
$ make run PORT=127.0.0.1:3306 \
           DATA_DIR=/srv/docker/lon-dev-db1 \
           USER=super \
           PASS=Whatz03v3r
```

## Connecting to the Database

To connect to the Percona server, you will need to make sure you have a client.
You can install the `mariadb` (an open-source drop-in replacement for MySQL) on your host machine by running the
following (Fedora 20):

``` shell
$ sudo yum install mariadb
```

As part of the startup for MariaDB, the container will generate a random
password for the superuser.  To view the login in run `docker logs
<container_name>` like so:

``` shell
$ docker logs percona1
PERCONA_USER=super
PERCONA_PASS=Whatz03v3r
PERCONA_DATA_DIR=/data
Starting Percona MySQL...
140623 12:31:49 mysqld_safe Logging to '/data/mysql.log'.
140623 12:31:49 mysqld_safe Starting mysqld daemon with databases from /data
```

Then you can connect to the Percona server from the host with the following
command:

``` shell
$ mysql -u super --password=Whatz03v3r --protocol=tcp
```
