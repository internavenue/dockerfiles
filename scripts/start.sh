#!/bin/bash
# Starts up the Phabricator stack within the container.

# Stop on error
set -e

DATA_DIR=/srv/www/phabricator
LOG_DIR=/var/log

if [[ -e /first_run ]]; then
  source /scripts/first_run.sh
else
  source /scripts/normal_run.sh
fi

pre_start_action
post_start_action

echo "Starting SSHd"
service sshd start

echo "Starting PHP-FPM..."
service php-fpm start

echo "Starting Nginx..."
/usr/sbin/nginx
