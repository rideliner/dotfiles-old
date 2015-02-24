function user() {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
  return 0
}

function success() {
  printf "\r\033[2K  [ \033[0;32mOK\033[0m ] $1\n"
  return 0
}

function fail() {
  printf "\r\033[2K  [ \033[0;31mFAIL\033[0m ] $1\n"
  return 1
}

function warning() {
  printf "\r\033[2K  [ \033[0;33mWARN\033[0m ] $1\n"
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
