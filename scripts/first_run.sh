USER=${USER:-super}
PASS=${PASS:-$(pwgen -s -1 16)}

pre_start_action() {
  # Echo out info to later obtain by running `docker logs container_name`
  echo "PERCONA_USER=$USER"
  echo "PERCONA_PASS=$PASS"
  echo "PERCONA_DATA_DIR=$DATA_DIR"

  # Check if the data directory does not exist.
  if [ ! -d "$DATA_DIR" ]; then
    mkdir /data
  fi

  # test if DATA_DIR has content
  if [[ ! "$(ls -A $DATA_DIR)" ]]; then
      echo "Initializing PerconaDB at $DATA_DIR"
      # Copy the data that we generated within the container to the empty DATA_DIR.
      cp -R /var/lib/mysql/* $DATA_DIR
  fi

  # Ensure mysql owns the DATA_DIR
  chown -R mysql:mysql $DATA_DIR
  chown -R mysql:mysql /var/log/mysql
}

post_start_action() {
  # Create the superuser.
  mysql -u root <<-EOF
DELETE FROM mysql.user WHERE user = '$USER';
FLUSH PRIVILEGES;
CREATE USER '$USER'@'localhost' IDENTIFIED BY '$PASS';
GRANT ALL PRIVILEGES ON *.* TO '$USER'@'localhost' WITH GRANT OPTION;
CREATE USER '$USER'@'%' IDENTIFIED BY '$PASS';
GRANT ALL PRIVILEGES ON *.* TO '$USER'@'%' WITH GRANT OPTION;
EOF

  rm /first_run
}
