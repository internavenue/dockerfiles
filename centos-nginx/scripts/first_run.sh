pre_start_action() {
  /usr/bin/ssh-keygen -A
  mkdir -p $DATA_DIR
  mkdir -p "$LOG_DIR/nginx"
}

post_start_action() {
  rm /first_run
}
