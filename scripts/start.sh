#!/bin/bash
# Starts up Nginx within the container.

# Stop on error
set -e

DATA_DIR=/srv/www
LOG_DIR=/var/log
  
# Check if the data directory does not exist.
if [ ! -d "$LOG_DIR/mysql" ]; then
  mkdir -p "$LOG_DIR/mysql"
  chown nginx:nginx "$LOG_DIR/mysql"
fi

# echo Starting SSHd
service sshd start

# Start Nginx
echo "Starting Nginx..."
/usr/sbin/nginx
