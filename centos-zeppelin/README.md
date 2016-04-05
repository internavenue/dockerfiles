# docker-centos-zeppelin

A Dockerfile that produces a  Centos-based Docker image that will install the necessary dependencies to run the latest stable [Apache Zeppelin][zeppelin].

[zeppelin]: http://zeppelin.incubator.apache.org/


This image assumes a built version of Zeppelin installed at /zeppelin. See instructions below.

## Image Creation

This example creates the image with the tag `internavenue/centos-zeppelin`, but you can change this to use your own username.


```
$ docker build -t="internavenue/centos-zeppelin" .
```

Alternately, you can run the following if you have *GNU Make* installed and if you'd like to build Zeppelin with an external Spark pre-built or custom build. By default, the Makefile choses an external pre-built Spark package.

```
$ make
```

You can also specify a custom docker username like so:

```
$ make DOCKER_USER=internavenue
```

## Usage

Zeppelin needs to connect to port 8081 for the web sockets, therefore it is suggested to map the default internal ports to the same ones in the host

```
sudo docker run -t -i -p 8080:8080 -p 8081:8081 -v /srv/docker/lon-dev-zeppelin1/zeppelin:/zeppelin internavenue/centos-zeppelin:centos7

```

## Setup Zeppelin installation for the first time 

For this, you need to ssh into the container and run the `first_run.sh script`

```
sudo docker run -t -i -p 8080:8080 -p 8081:8081 -v /srv/docker/lon-dev-zeppelin1/zeppelin:/zeppelin internavenue/centos-zeppelin:centos7 bash
```

Once inside, execute
```
sh /scripts/first_run.sh
```
