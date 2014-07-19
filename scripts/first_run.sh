pre_start_action() {
  cd /srv/www/phabricator

  if [[ ! "$(ls -A libphutil)" ]]; then
    echo "Cloning libphutil..."
    git clone https://github.com/facebook/libphutil.git
  else
    echo "The directory of libphutil is not empty. Left as is."
  fi

  if [[ ! "$(ls -A libphutil)" ]]; then
    echo "Cloning Arcanist..."
    git clone https://github.com/facebook/arcanist.git
  else
    echo "The directory of Arcanist is not empty. Left as is."
  fi

  if [[ ! "$(ls -A libphutil)" ]]; then
    echo "Cloning Phabricator..."
    git clone https://github.com/facebook/phabricator.git
  else
    echo "The directory of Phabricator is not empty. Left as is."
  fi

  cd phabricator
  bin/config set mysql.host $MYSQL_PORT_3306_TCP_ADDR
  bin/config set mysql.port $MYSQL_PORT_3306_TCP_PORT
  bin/config set mysql.user $MYSQL_ENV_USER
  bin/config set mysql.pass $MYSQL_ENV_PASS
  bin/storage upgrade
  bin/phd start

  chown -R nginx:nginx /srv/www/phabricator
  chown -R nginx:nginx /var/log/nginx

  mkdir -p /var/log/php-fpm
}

post_start_action() {
  rm /first_run
}
