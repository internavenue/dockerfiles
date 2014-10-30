#!/bin/bash
# Starts up PerconaDB within the container.

# Stop on error
set -e

DATA_DIR=/data
LOG_DIR=/var/log

if [[ -e /first_run ]]; then
  source /scripts/first_run.sh
else
  source /scripts/normal_run.sh
fi

wait_for_mysql_and_run_post_start_action() {
  # Wait for mysql to finish starting up first.
  while [[ ! -e ${DATA_DIR}/mysql.sock ]] ; do
      inotifywait -q -e create ${DATA_DIR} >> /dev/null
  done

  post_start_action
}

pre_start_action

wait_for_mysql_and_run_post_start_action &

echo "Starting SSHd"
service sshd start

echo "Starting Percona MySQL..."
exec /etc/init.d/mysqld start
