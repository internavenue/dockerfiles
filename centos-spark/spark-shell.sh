#!/usr/bin/env bash
docker pull internavenue/centos-spark
# Run the container, all ports randomly allocated in the host
docker run -i -t -P --link spark_master:spark_master internavenue/centos-spark /spark-shell.sh "$@"
