#!/bin/bash

# Environment variables
SPARK_PROFILE=1.6
SPARK_VERSION=1.6.1
HADOOP_PROFILE=2.6
HADOOP_VERSION=2.6.0

# Setup and run Zeppelin
cd /zeppelin
mvn -T "$(nproc)" clean package -DskipTests -Pspark-$SPARK_PROFILE -Dspark.version=$SPARK_VERSION

# Start Zeppelin
bin/zeppelin-daemon.sh start
