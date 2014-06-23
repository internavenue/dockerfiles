pre_start_action() {
  # Cleanup previous sockets
  rm -f /data/mysql.sock
}

post_start_action() {
  : # No-op
}
