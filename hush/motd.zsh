# Only show the motd when it changes
function() {
  local md5
  md5=$(md5sum -t /etc/motd | cut -f1 -d' ')
  if ! cmp -s ~/.hushlogin =(echo $md5); then
    echo "$md5" >| ~/.hushlogin
    cat /etc/motd
  fi
}
