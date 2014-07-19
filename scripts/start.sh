#!/bin/bash
# Starts up the Centos Base container.

# Stop on error
set -e

LOG_DIR=/var/log
  
service sshd start
service syslog-ng start
