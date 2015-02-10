#!/bin/bash
# Starts up NSQd within the container.

# Stop on error
set -e

DATA_DIR=/data
LOG_DIR=/var/log
 
# Check if the data directory does not exist.
if [ ! -d "$LOG_DIR/nsq" ]; then
  mkdir -p "$LOG_DIR/nsq"
fi

if [[ -e /first_run ]]; then
  source /scripts/first_run.sh
else
  source /scripts/normal_run.sh
fi

chown -R nginx:nginx "$LOG_DIR/nsq"

echo "Starting Syslog-ng..."
syslog-ng --no-caps

echo "Starting SSHd..."
/usr/sbin/sshd

echo "Starting Bash..."
/bin/bash
