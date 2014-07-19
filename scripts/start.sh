#!/bin/bash
# Starts up Nginx and PHP-FPM within the container.

# Stop on error
set -e

service sshd start
service php-fpm start

echo "Starting Nginx..."
/usr/sbin/nginx
