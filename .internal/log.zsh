function dotfiles/log/module() {
  printf "\r\e[2K${3:-\u2523}[ $1 ] $2"
}

function dotfiles/log/user() {
  dotfiles/log/module "  \e[0;35m?\e[0m " "$1 " ${*[2, -1]}
  return 0
}

function dotfiles/log/success() {
  dotfiles/log/module " \e[0;32mOK\e[0m " "$1\n" ${*[2, -1]}
  return 0
}

function dotfiles/log/fail() {
  dotfiles/log/module "\e[0;31mFAIL\e[0m" "$1\n" ${*[2, -1]}
  return 1
}

function dotfiles/log/warning() {
  dotfiles/log/module "\e[0;33mWARN\e[0m" "$1\n" ${*[2, -1]}
  return 2
}

function dotfiles/log/info() {
  dotfiles/log/module "\e[0;33mINFO\e[0m" "$1\n" ${*[2, -1]}
}

function dotfiles/log/sub() {
  printf "\r\e[2K\u2523\u2501 $1"
}

function dotfiles/log/status() {
  if [[ $1 -eq 0 ]]; then
    dotfiles/log/success "$2" ${*[3, -1]}
  else
    dotfiles/log/fail "$2" ${*[3, -1]}
  fi

  return $?
}

function dotfiles/log/wrapper/start() {
  dotfiles/log/module "\e[0;36m$1\e[0m" "$2\n" "\u250F"
}

function dotfiles/log/wrapper/end() {
  dotfiles/log/status $? "$1" "\u2517"
}

function dotfiles/debugReturn() {
  local _somethingRandomAndUnused
  $1 ${*[2, -1]} _somethingRandomAndUnused
  echo "$_somethingRandomAndUnused"
}
