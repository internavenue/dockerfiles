#!/bin/bash
# Starts up Nginx and PHP-FPM within the container.

# Stop on error
set -e

echo "Starting SSHd"
service sshd start

echo "Starting PHP-FPM..."
service php-fpm start

echo "Starting Nginx..."
/usr/sbin/nginx
