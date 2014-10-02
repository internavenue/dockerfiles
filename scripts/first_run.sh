pre_start_action() {
  /usr/bin/ssh-keygen -A
}

post_start_action() {
  rm /first_run
}
