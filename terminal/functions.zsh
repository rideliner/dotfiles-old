
function mcd() {
  mkdir "$1" && cd "$1"
}

function aes-enc() {
  openssl enc -aes-256-cbc -e -in $1 -out "$1.aes"
}

function aes-dec() {
  openssl enc -aes-256-cbc -d -in $1 -out "${1%.*}"
}

function maxcpu() {
  local dn=/dev/null
  yes > $dn & yes > $dn & yes > $dn & yes > $dn &
  yes > $dn & yes > $dn & yes > $dn & yes > $dn &
}

function clearcpu() {
  killall yes
}

# xclip shortcuts for clipboard
if (( $+commands[xclip] )); then
  function cb() {
    local input
    if ! [[ "$(tty)" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    else
      input="$*"
    fi

    echo -n "$input" | xclip -selection c
  }

  # Copy contents of a file
  function cbf() {
    cat "$1" | cb
  }

  # Copy current working directory
  alias cbwd="pwd | cb"

  # Copy most recent command in bash history
  alias cbhs="cat $HISTFILE | tail -n 1 | cb"
fi

if (( $+commands[vncviewer] )); then
  function vnc() {
    vncviewer DotWhenNoCursor=1 "$*"
  }
fi

if (( $+commands[x0vncserver] )); then
  function vnc/server() {
    x0vncserver -display :0 -passwordfile ~/.vnc/passwd
  }
fi
