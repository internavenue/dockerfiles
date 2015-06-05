# docker-centos-spark

A Dockerfile that produces a  Centos-based Docker image that will run a standalone pre-build version of [ApacheSpark][spark].

[spark]: https://spark.apache.org/


## Image Creation

This example creates the image with the tag `internavenue/centos-spark`, but you can change this to use your own username.


```
$ docker build -t="internavenue/centos-spark" .
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

```
sudo docker run -t -i -p internavenue/centos-spark:centos7
```

Spark is by default placed at /opt/spark

You can run a test (estimate Pi number) with the following command within the container

```
/opt/spark/bin/run-example SparkPi 10
```

##To-Do

Map ports, build from source? ...