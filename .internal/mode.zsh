function user() {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

function success() {
  printf "\r\033[2K  [ \033[0;32mOK\033[0m ] $1\n"
}

function fail() {
  printf "\r\033[2K  [ \033[0;31mFAIL\033[0m ] $1\n"
}

function warning() {
  printf "\r\033[2K  [ \033[0;33mWARN\033[0m ] $1\n"
}
