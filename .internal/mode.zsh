function user() {
  printf "\r[   \e[0;33m?\e[0m  ] $1 "
  return 0
}

function success() {
  printf "\r\e[2K[  \e[0;32mOK\e[0m  ] $1\n"
  return 0
}

function fail() {
  printf "\r\e[2K[ \e[0;31mFAIL\e[0m ] $1\n"
  return 1
}

function warning() {
  printf "\r\e[2K[ \e[0;33mWARN\e[0m ] $1\n"
  return 2
}

function status() {
  if [[ $1 -eq 0 ]]; then
    success "$2"
  else
    fail "$2"
  fi

  return $?
}
