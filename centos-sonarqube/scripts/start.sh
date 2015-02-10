#!/bin/bash
# Starts up SonarQube within the container.

# Stop on error
set -e

LIB_DIR=/var/lib/jenkins
LOG_DIR=/var/log
CACHE_DIR=/var/cache/jenkins/war

if [[ -e /first_run ]]; then
  source /scripts/first_run.sh
else
  source /scripts/normal_run.sh
fi

pre_start_action
post_start_action

chown -R jenkins:jenkins $LIB_DIR
chown -R jenkins:jenkins $CACHE_DIR
chown -R jenkins:jenkins "$LOG_DIR/jenkins"

echo "Starting Syslog-ng..."
syslog-ng --no-caps

echo "Starting SSHd..."
/usr/sbin/sshd

echo "Starting Jenkins..."
/etc/init.d/jenkins start
