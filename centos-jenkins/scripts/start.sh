#!/bin/bash
# Starts up the Jenkins stack within the container.

# Stop on error
set -e

DATA_DIR=/var/lib/jenkins
LOG_DIR=/var/log

if [[ -e /first_run ]]; then
  source /scripts/first_run.sh
else
  source /scripts/normal_run.sh
fi

pre_start_action
post_start_action

chown jenkins:jenkins $DATA_DIR
chown jenkins:jenkins "$LOG_DIR/jenkins"

echo "Starting Syslog-ng..."
syslog-ng --no-caps

echo "Starting SSHd..."
/usr/sbin/sshd

echo "Starting Nginx..."
/etc/init.d/jenkins.nodaemon start
