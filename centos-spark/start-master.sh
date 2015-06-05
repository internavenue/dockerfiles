#!/usr/bin/env bash
docker pull internavenue/centos-spark
# Run the container, all ports randomly allocated in the host
docker run -d -t -P --name spark_master internavenue/centos-spark /start-master.sh "$@"
