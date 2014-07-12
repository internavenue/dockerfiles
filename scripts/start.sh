#!/bin/bash
# Starts up Nginx within the container.

# Stop on error
set -e

DATA_DIR=/srv/www

# Start Nginx
echo "Starting Nginx..."
/usr/sbin/nginx
