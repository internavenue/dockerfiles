pre_start_action() {
  mkdir -p $DATA_DIR
  mkdir -p "$LOG_DIR/php-fpm"

  cd $WWW_DIR

  if [ ! -d $WWW_DIR ]; then
    echo "Cloning COPS..."
    cd $WWW_DIR
    git clone https://github.com/seblucas/cops.git
  else
    echo "The directory of COPS is not empty. Left as is."
  fi

  chown -R nginx:nginx $WWW_DIR
}

post_start_action() {
  rm /first_run
}

