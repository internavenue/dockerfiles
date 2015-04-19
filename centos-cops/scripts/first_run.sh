pre_start_action() {
  mkdir -p $DATA_DIR
  mkdir -p "$LOG_DIR/php-fpm"

  if [ ! -d $WWW_DIR ]; then
    echo "Cloning COPS..."
    cd $WWW_DIR
    git clone https://github.com/seblucas/cops.git
    mv /srv/www/config_local.php /srv/www/cops
  else
    echo "The directory of COPS is not empty. Left as is."
  fi

  chown -R $PHP_USER:$PHP_GROUP $WWW_DIR
}

post_start_action() {
  rm /first_run
}

