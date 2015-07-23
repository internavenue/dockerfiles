# docker-centos-nlp4l

A Dockerfile that produces a Centos-based Docker image that will run the latest [NLP4L][nlp4l]

[nlp4l]: https://github.com/NLP4L/nlp4l


## Image Creation

This example creates the image with the tag `internavenue/centos-nlp4l`, but you can change this to use your own username.


```
$ docker build -t="internavenue/centos-nlp4l" .
```

## Usage

```
sudo docker run -t -i -p internavenue/centos-nlp4l:centos7
```

Once inside, you can run NLP4l with

```
target/pack/bin/nlp4l
```
