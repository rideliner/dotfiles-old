#!/usr/bin/env zsh

function dotfiles/resolve/home() {
  local __removed="${1#\~}"
  if [[ "$__removed" == "$1" ]]; then
    echo "$1"
  else
    echo "$HOME$__removed"
  fi
}

function dotfiles/resolve/moduleName() {
  echo "${1//\!/$2}"
}

function dotfiles/resolve/fileBaseName() {
  echo "${1//\?/$2}"
}

function dotfiles/resolve/relativeToDirectory() {
  local __removed="${1#./}"
  if [[ "$__removed" == "$1" ]]; then
    echo "$1"
  else
    echo "$2/$__removed"
  fi
}

function dotfiles/resolve/currentUserPartition() {
  local __removed="${1%@*}"
  if [[ "$__removed" == "$1" ]]; then
    echo "$1"
  else
    echo "$__removed@$USER"
  fi
}

# symlink <path> <symlink-file-basename> <module-name>
function dotfiles/resolve/symlink() {
  local __intermediate

  __intermediate="$1"
  __intermediate=$(dotfiles/resolve/fileBaseName "$__intermediate" "$2")
  __intermediate=$(dotfiles/resolve/moduleName "$__intermediate" "$3")
  __intermediate=$(dotfiles/resolve/home "$__intermediate" "$HOME")

  echo "$__intermediate"
}
