#!/bin/bash
# Starts up the Phabricator stack within the container.

# Stop on error
set -e

DATA_DIR=/var/lib/haproxy
LOG_DIR=/var/log

if [[ -e /first_run ]]; then
  source /scripts/first_run.sh
else
  source /scripts/normal_run.sh
fi

pre_start_action
post_start_action

chown haproxy:haproxy $DATA_DIR
chown haproxy:haproxy "$LOG_DIR/haproxy"

echo "Starting Syslog-ng..."
syslog-ng --no-caps

echo "Starting SSHd..."
/usr/sbin/sshd

echo "Starting HAproxy..."
/usr/sbin/haproxy-systemd-wrapper -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid
