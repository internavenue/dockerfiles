pre_start_action() {
  # Cleanup previous sockets
  rm -f /var/lib/mysql/mysql.sock
}

post_start_action() {
  : # No-op
}
