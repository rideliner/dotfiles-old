function moduleMode() {
  printf "\r\e[2K${3:=\u2523}[ $1 ] $2"
}

function user() {
  moduleMode "  \e[0;35m?\e[0m " "$1 " "$*[2, -1]"
  return 0
}

function success() {
  moduleMode " \e[0;32mOK\e[0m " "$1\n" "$*[2, -1]"
  return 0
}

function fail() {
  moduleMode "\e[0;31mFAIL\e[0m" "$1\n" "$*[2, -1]"
  return 1
}

function warning() {
  moduleMode "\e[0;33mWARN\e[0m" "$1\n" "$*[2, -1]"
  return 2
}

function status() {
  if [[ $1 -eq 0 ]]; then
    success "$2" "$*[3, -1]"
  else
    fail "$2" "$*[3, -1]"
  fi

  return $?
}
