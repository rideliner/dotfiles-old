
function chpy() {
  if [[ $# != 1 || $1 != "python2" && $1 != "python3" ]]; then
    echo "Usage:"
    echo "\t$0 python2"
    echo "\t$0 python3"
    return -1
  fi

  if (( ! $+commands[$1] )); then
    echo "$1 is not installed or is not in your path"
    return -2
  fi

  sudo rm /usr/sbin/python
  sudo rm /usr/sbin/python-config

  sudo ln -s "$commands[$1]" /usr/sbin/python
  sudo ln -s "$commands[$1-config]" /usr/sbin/python-config
}
