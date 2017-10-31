function dotfiles/zstyle/isSet() {
  zstyle -t "$1" "$2"
  [ $? -le 1 ]
  return $?
}

function dotfiles/zstyle/isUnsetOrTrue() {
  zstyle -T "$1" "$2"
  [ $? -eq 0 ]
  return $?
}

function dotfiles/zstyle/valueOrDefault() {
  if dotfiles/zstyle/isSet "$1" "$2"; then
    local value
    zstyle -s "$1" "$2" value
    echo "$value"
  else
    echo "$3"
  fi
}

zstyle ':ride:*:symlink:*' path '~'
zstyle ':ride:*:symlink:*' name '.?'

zstyle ':ride:_checks' privileged dotfiles/check/hasProperPrivileges
zstyle ':ride:_checks' groups dotfiles/check/inMyGroups
zstyle ':ride:_checks' anyCommands dotfiles/check/hasAnyCommandsAvailable
zstyle ':ride:_checks' allCommands dotfiles/check/hasAllCommandsAvailable
zstyle ':ride:_checks' enabled dotfiles/check/isEnabled
