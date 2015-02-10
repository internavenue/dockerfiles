pre_start_action() {
  mkdir -p $SESSION_DIR
  mkdir -p $WSDL_CACHE_DIR
  mkdir -p $LOG_DIR
  mkdir -p $LOCK_DIR
  /usr/bin/ssh-keygen -A
}

post_start_action() {
  rm /first_run
}
