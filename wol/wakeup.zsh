function wakeup() {
  local mac
  zstyle -s ":ride:wol:mac" $1 mac

  ssh -T lemon.vpn.rideliner.net "wol $mac"
}
