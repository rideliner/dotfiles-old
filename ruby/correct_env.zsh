
function() {
  local binary
  local -a binaries
  binaries=(/usr/bin/gem /usr/bin/ri /usr/bin/erb /usr/bin/rake /usr/bin/rdoc /usr/bin/irb)

  for binary in $binaries; do
    if [[ -f $binary ]]; then
      alias "${binary:t}"="ruby $binary"
    fi
  done
}
