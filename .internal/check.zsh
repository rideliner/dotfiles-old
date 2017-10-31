source "${0:A:h}/zstyle.zsh"
source "$DOTFILES_PATH/.internal/groups.zsh"

function dotfiles/check/isEnabled() {
  dotfiles/zstyle/isUnsetOrTrue "$1" enabled
  return $?
}

function dotfiles/check/hasProperPrivileges() {
  zstyle -t "$1" privileged

  case $? in
    0 )
      [ $UID -eq 0 ]
      return $?
      ;;
    1 )
      [ $UID -ne 0 ]
      return $?
      ;;
    2 )
      return 0
      ;;
  esac
}

function dotfiles/util/intersection() {
  echo ${(@f)$(comm -12 =(echo "${(@F)${(@o)${(P)1}}}") =(echo "${(@F)${(@o)${(P)2}}}"))}
}

function dotfiles/util/extras() {
  echo ${(@f)$(comm -13 =(echo "${(@F)${(@o)${(P)1}}}") =(echo "${(@F)${(@o)${(P)2}}}"))}
}

function dotfiles/check/inSimilarGroups() {
  local -Ua groups intersect remain
  zstyle -a "$1" groups groups

  if [ ${#groups} -eq 0 ]; then
    return 0
  fi

  remain=(${*[2, -1]})
  intersect=($(dotfiles/util/intersection remain groups))
  [ $#intersect != 0 ]
  return $?
}

function dotfiles/check/inMyGroups() {
  local -Ua _groups
  dotfiles/groups/getMine _groups
  dotfiles/check/inSimilarGroups "$1" $_groups
  return $?
}

function dotfiles/check/hasAnyCommandsAvailable() {
  local -Ua cmds
  local cmd
  zstyle -a "$1" anyCommands cmds

  if [ ${#cmds} -eq 0 ]; then
    return 0
  fi

  for cmd in $cmds; do
    (( $+commands[$cmd] )) && return 0
  done

  return 1
}

function dotfiles/check/hasAllCommandsAvailable() {
  local -Ua cmds
  local cmd
  zstyle -a "$1" allCommands cmds

  for cmd in $cmds; do
    (( $+commands[$cmd] )) || return 1
  done

  return 0
}

function dotfiles/check/isActive() {
  local -Ua checks
  local check

  checks=($(zstyle -L ':ride:_checks' | cut -d' ' -f4))

  for check in $checks; do
    $check "$1"
    if [[ $? -ne 0 ]]; then
      return 1
    fi
  done

  return 0
}

function dotfiles/check/debugActive() {
  local -Ua checks
  local final check
  final=0

  checks=($(zstyle -L ':ride:_checks' | cut -d' ' -f4))

  for check in $checks; do
    $check "$1"
    if (( $? != 0 )); then
      dotfiles/log/fail "$check"
      final=$?
    fi
  done

  return $final
}

function dotfiles/check/ifInGroup() {
  if dotfiles/check/inMyGroups "$1"; then
    echo -n "$2"
  else
    echo -n ""
  fi
}
