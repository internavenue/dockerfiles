pre_start_action() {
  mkdir -p $DATA_DIR
  mkdir -p "$LOG_DIR/jenkins"
}

post_start_action() {
  rm /first_run
}
