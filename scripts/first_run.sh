pre_start_action() {
  cd /srv/www/phabricator
  git clone https://github.com/facebook/libphutil.git
  git clone https://github.com/facebook/arcanist.git
  git clone https://github.com/facebook/phabricator.git

  cd phabricator
  bin/config set mysql.host $MYSQL_PORT_3306_TCP_ADDR
  bin/config set mysql.port $MYSQL_PORT_3306_TCP_PORT
  bin/config set mysql.user $MYSQL_ENV_DB_USER
  bin/config set mysql.pass $MYSQL_ENV_DB_PASS

  chown -R nginx:nginx /srv/www/phabricator
  chown -R nginx:nginx /var/log/nginx

  mkdir -p /var/log/php-fpm
}

post_start_action() {
  rm /first_run
}
