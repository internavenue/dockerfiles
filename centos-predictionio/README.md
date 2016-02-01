# docker-centos-predictionio

A Dockerfile that produces a  Centos-based Docker image that will prepare the dependencies needed to run [Prediction.io][predictionio].

[predictionio]: https://prediction.io/


## Image Creation

This example creates the image with the tag `internavenue/centos-predictionio`, but you can change this to use your own username.


```
sudo docker build -t="internavenue/centos-predictionio" .
```

You can also specify a custom docker username like so:

```
make DOCKER_USER=internavenue
```


## Usage

Predictionio needs to connect to port 8000 to serve predictions and its event server needs to have 7070 exposed, therefore it is suggested to map the default internal ports to the same ones in the host

```
sudo docker run -t -i -v /vagrant:/vagrant -p 7070:7070 -p 8000:8000 internavenue/centos-predictionio:centos7
```
