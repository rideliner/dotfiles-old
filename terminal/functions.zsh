
function aes-enc() {
  openssl enc -aes-256-cbc -e -in $1 -out "$1.aes"
}

function aes-dec() {
  openssl enc -aes-256-cbc -d -in $1 -out "${1%.*}"
}

function maxcpu() {
  dn=/dev/null
  yes > $dn & yes > $dn & yes > $dn & yes > $dn &
  yes > $dn & yes > $dn & yes > $dn & yes > $dn &
}

function clearcpu() {
  killall yes
}
