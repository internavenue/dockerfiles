# docker-centos-zeppelin

A Dockerfile that produces a  Centos-based Docker image that will run the latest stable [Apache Zeppelin][zeppelin].

[zeppelin]: http://zeppelin.incubator.apache.org/


## Image Creation

This example creates the image with the tag `internavenue/centos-zeppelin`, but you can change this to use your own username.


```
$ docker build -t="internavenue/centos-zeppelin" .
```

Alternately, you can run the following if you have *GNU Make* installed...

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
sudo docker run -t -i -p 8080:8080 -p 8081:8081 internavenue/centos-zeppelin:centos7
```
