pre_start_action() {
  /usr/bin/ssh-keygen -A
  mkdir -p $DATA_DIR
  mkdir -p "$LOG_DIR/nsq"
}

post_start_action() {
  rm /first_run
}
