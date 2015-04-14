pre_start_action() {
  mkdir -p $DATA_DIR
  mkdir -p "$LOG_DIR/nginx"

  cd $DATA_DIR

  if [ ! -d libphutil ]; then
    echo "Cloning libphutil..."
    git clone https://github.com/facebook/libphutil.git
  else
    echo "The directory of libphutil is not empty. Left as is."
  fi

  if [ ! -d arcanist ]; then
    echo "Cloning Arcanist..."
    git clone https://github.com/facebook/arcanist.git
  else
    echo "The directory of Arcanist is not empty. Left as is."
  fi

  if [ ! -d phabricator ]; then
    echo "Cloning Phabricator..."
    git clone https://github.com/facebook/phabricator.git
  else
    echo "The directory of Phabricator is not empty. Left as is."
  fi

  if [ ! -d libext/sprint ]; then
    echo "Cloning Mediawiki Sprint extension"
    git clone https://github.com/wikimedia/phabricator-extensions-Sprint.git
    mkdir -p libext
    mv phabricator-extensions-Sprint libext/sprint
  fi

  cd phabricator
  bin/config set mysql.host $MYSQL_PORT_3306_TCP_ADDR
  bin/config set mysql.port $MYSQL_PORT_3306_TCP_PORT
  bin/config set mysql.user $MYSQL_ENV_USER
  bin/config set mysql.pass $MYSQL_ENV_PASS
  bin/config set load-libraries: '{"sprint":"/srv/www/phabricator/libext/sprint/src"}'
  bin/config set pygments.enabled true
  bin/storage upgrade --force
  bin/phd start

  chown -R nginx:nginx $DATA_DIR
  chown -R nginx:nginx "$LOG_DIR/nginx"

  mkdir -p /var/log/php-fpm
}

post_start_action() {
  rm /first_run
}
