source "${0:A:h}/modules.zsh"
source "$DOTFILES_PATH/.internal/log.zsh"

function dotfiles/dependencies/getModulesResolved() {
  local _some _all _final

  dotfiles/modules/getActive _some

  if [[ ${#_some} -eq 0 ]]; then
    dotfiles/log/fail 'No modules are enabled for this user/host setup.' ' '
    return $?
  fi

  dotfiles/dependencies/resolveAll _some _all
  if (( $? != 0 )); then
    dotfiles/log/info "To see why modules are not active, run \`dotfiles/debug/inactive\`" ' '
  fi

  eval "$1=($_all)"
}

function dotfiles/dependencies/verifyActive() {
  local _extras _extra
  _extras=($(dotfiles/util/extras $2 $3))

  for _extra ($_extras); do
    dotfiles/log/fail "$_extra is a dependency of $1, but is not active" ' '
  done
}

function dotfiles/dependencies/resolveAll() {
  local -a dependencies
  local -Ua total

  for _mod (${(P)=1}); do
    dotfiles/dependencies/resolve $_mod dependencies
    total+=($dependencies)

    dotfiles/dependencies/verifyActive "$_mod" "$1" dependencies
  done

  eval "$2=($total)"
}

function dotfiles/dependencies/resolve() {
  local -a resolved unresolved
  dotfiles/dependencies/resolveInternal "$1" resolved unresolved

  eval "$2=($resolved)"
}

function dotfiles/dependencies/resolveInternal() {
  eval "$3+=($1)" # add to unresolved

  zstyle -a ":ride:$1" depend nodes

  for edge in $nodes; do
    # if edge not in resolved
    if [[ $(eval "echo \${$2[(i)$edge]}") -gt $(eval "echo \${#$2}") ]]; then
      # if edge in unresolved
      if [[ $(eval "echo \${$3[(i)$edge]}") -le $(eval "echo \${#$3}") ]]; then
        echo "Circular dependency detected: $1 -> $edge" >&2
        exit 1
      fi

      # recursive dependency check
      dotfiles/dependencies/resolveInternal "$edge" $2 $3
    fi
  done

  eval "$2+=($1)" # add to resolved
  eval "$3=(\"\${$3[@]/#%$1}\")" # remove from unresolved
}
