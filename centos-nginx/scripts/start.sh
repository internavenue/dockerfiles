#!/bin/bash
# Starts up Nginx within the container.

# Stop on error
set -e

DATA_DIR=/srv/www
LOG_DIR=/var/log
 
# Check if the data directory does not exist.
if [ ! -d "$LOG_DIR/nginx" ]; then
  mkdir -p "$LOG_DIR/nginx"
fi

if [[ -e /first_run ]]; then
  source /scripts/first_run.sh
else
  source /scripts/normal_run.sh
fi

chown -R nginx:nginx "$LOG_DIR/nginx"

echo "Starting Syslog-ng..."
syslog-ng --no-caps

echo "Starting SSHd..."
/usr/sbin/sshd

echo "Starting Nginx..."
/usr/sbin/nginx

